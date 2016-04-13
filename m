From: james.morse@arm.com (James Morse)
Date: Wed, 13 Apr 2016 17:12:35 +0100
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <CAG_fn=Xe5r3qveX356gUZWmt29Bw0XUrg5KHEbaRdJm=tDYLkw@mail.gmail.com>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>	<20160331142908.GG26532@leverpostej>	<CAG_fn=V+e=+-svWOCUirOy4SvBNgJR5JWCFDU3uE3aKwz9ihvw@mail.gmail.com>	<20160331160052.GA26393@leverpostej>	<CAG_fn=Vgvuaoz_jUNcyxvFdu4LpyO55AWmTzGvCVhOYoaX9y7Q@mail.gmail.com>	<20160331171434.GC26393@leverpostej>	<CAG_fn=UGRMM-dJYNO3RF5zcC5p=x-+5yvk+KqU5aRbAH9p+pHw@mail.gmail.com>	<CACT4Y+Y_zb0LmcXys6HF=Y_5Y+vaJmwyL_kps2p6je7p2dQPVg@mail.gmail.com>
 <CAG_fn=Xe5r3qveX356gUZWmt29Bw0XUrg5KHEbaRdJm=tDYLkw@mail.gmail.com>
Message-ID: <570E6FF3.5000104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 12/04/16 12:17, Alexander Potapenko wrote:
> I also wonder if we can, say, land the change to arch/arm64/Kconfig
> separately from makefile changes that improve the precision or fix
> certain build configurations.

(I'm not sure what you mean by precision)

It depends which build configurations get broken, for example the first build I
tried doesn't boot.

I tested the Kconfig change, and added 'KCOV_INSTRUMENT := n' to kvm's two
Makefiles[0].

defconfig+KCOV boots fine, and I can start a guest, but if I build with
defconfig+KCOV+STACK_TRACER, I get a kernel that fails to boot. It boils down to
a loop between ftrace and kcov, I will send a patch.


It looks like syzkaller is the only user of this data, and it doesn't appear to
support arm64:
> 2016/04/13 15:42:55 failed to create instance: qemu stopped:
> "kvm" accelerator not found.
> No accelerator found!

This happens because syzkaller expects to be able to use 'qemu-system-x86_64':
> [pid  3670] execve("/usr/bin/qemu-system-x86_64", ["qemu-system-x86_64",
> "-hda", "/foo.img", "-snapshot", "-m", "1024", "-net", "nic", "-net",
> "user,host=10.0.2.10,hostfwd=tcp:"..., "-nographic", "-enable-kvm", "-numa",
> "node,nodeid=0,cpus=0-1", "-numa", "node,nodeid=1,cpus=2-3", ...],

qemu-system-x86_64 is installed and works fine, it just doesn't have the
expected hardware acceleration...

My approximation of your qemu command for arm64 may be useful[1], but I'm not
able to hack the go source to fix it!



Thanks,

James



[0]
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 122cff482ac4..7d111f06bbf3 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -9,6 +9,10 @@ CFLAGS_mmu.o := -I.
 KVM=../../../virt/kvm
 ARM=../../../arch/arm/kvm

+# Code built here may run at EL2, in which case __sanitizer_cov_trace_pc() will
+# not be callable. For now, disable the instrumentation.
+KCOV_INSTRUMENT := n
+
 obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
 obj-$(CONFIG_KVM_ARM_HOST) += hyp/

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 778d0effa2af..1150f8664c85 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
 GCOV_PROFILE   := n
 KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n


[1]
qemu-system-aarch64 -enable-kvm
  -cpu host -m 1024 -M virt -nographic
  -kernel ./syzkaller/Image
  -append "console=ttyAMA0,115200 root=/dev/vda"
  -drive format=raw,file=/foo.img,media=disk,if=none,cache=writeback,id=root
  -device virtio-blk-device,drive=root
  -netdev user,host=10.0.2.10,hostfwd=tcp::23505-:22,id=unet
  -device virtio-net-device,netdev=unet
