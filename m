From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 9 Oct 2012 19:11:52 +0100
Subject: [kvmarm] [PATCH v2 12/14] KVM: ARM: VFP userspace interface
In-Reply-To: <20121001091125.49198.90819.stgit@ubuntu>
References: <20121001090945.49198.68950.stgit@ubuntu>
 <20121001091125.49198.90819.stgit@ubuntu>
Message-ID: <CAFEAcA8zLr5mPYnd6EzaxyugASWPzvY4RE6LiE-K2uRRGWtFZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2012 10:11, Christoffer Dall <c.dall@virtualopensystems.com> wrote:
> From: Rusty Russell <rusty.russell@linaro.org>
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1765,6 +1765,12 @@ ARM 64-bit CP15 registers have the following id bit patterns:
>  ARM CCSIDR registers are demultiplexed by CSSELR value:
>    0x4002 0000 0011 00 <csselr:8>
>
> +ARM 32-bit VFP control registers have the following id bit patterns:
> +  0x4002 0000 0012 1 <selector:3>
> +
> +ARM 64-bit FP registers have the following id bit patterns:
> +  0x4002 0000 0012 0 <selector:3>
> +

In the other entries in this section, <foo:3> indicates a 3 bit field.
But I think for these two it's trying to indicate a 3 byte field.
Compare the include file constants:

+#define KVM_REG_ARM_VFP                        (0x0012 <<
KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_VFP_MASK           0x000000000000FFFF
+#define KVM_REG_ARM_VFP_BASE_REG       0x0
+#define KVM_REG_ARM_VFP_FPSID          0x1000
+#define KVM_REG_ARM_VFP_FPSCR          0x1001

so eg the first control register is
 0x4002 0000 0012 1000
and the first D reg is
 0x4002 0000 0012 0000

So my guess is these should be <selector:12>
(or possibly even something slightly more specific than 'selector'
like '<regno:12>' ?)

-- PMM
