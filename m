From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 15 Nov 2013 13:28:21 +0200
Subject: [PATCH v2] ARM: kexec: Use the right ISA for relocate_new_kernel
In-Reply-To: <5282818B.9030903@linaro.org>
References: <1383913444-9153-1-git-send-email-Dave.Martin@arm.com>
 <20131108133426.GE17461@mudshark.cambridge.arm.com>
 <20131108184625.GE2602@localhost.localdomain> <5282818B.9030903@linaro.org>
Message-ID: <52860555.7010307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 09:29 PM, Taras Kondratiuk wrote:
> Hi Dave
> 
> Yes. I've tested it on Pandaboard and results are quite weird.
> ARM->ARM, Thumb->Thumb and Thumb->ARM kernel transition works fine
> for both kexec and kdump ways. But ARM->Thumb works for only kdump
> via kernel panic. In case of "kexec -e" the second Thumb kernel
> doesn't come up.
> 
> I don't have JTAG now. I will check this tomorrow morning.

Hi Dave, Will

The issue I observed is not caused by this patch.
I was able to reproduce it with my initial simple patch.

So for this one:
Reported-and-Tested-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>

And the issue I'm frequently facing in reloaded kernel (Thumb from ARM)
is random crashes caused by undefined instructions.

My observation summary:
- Before starting a second kernel I'm dumping loaded zImage and then
  unpacked Image at final location and they are correct, so no issue
  with loading.
- I observe two types of crash:
  1) Undefined instruction in the middle of kernel code. After a crash
     I check failing address and there is always a *valid* Thumb
     instruction (CPU is in Thumb mode).
  2) Jump to a wrong address which consequently causes undefined
     instruction exception. A trace of one example of a wrong jump is
     captured in [1]. Instead of jumping to 0xC049097C code gets
     executed at 0xED85E008. BTW the wrong address suspiciously looks
     like an ARM instruction.
- If second kernel is placed at different address (like in kdump case),
  then it boots fine and I don't observe any crashes.
- If I check failing address in the first kernel (ARM) the code there
  is really undefined instruction if executed as Thumb.
- Looks like pieces of old ARM kernel gets executed instead of new
  Thumb kernel. But as I've mentioned I'm reading physical memory via
  JTAG before starting second kernel and memory is matching a compiled
  Thumb 'Image'. Icache also gets cleaned...
- Once when stopped on breakpoint I've seen a piece of ARM code in
  Thumb kernel. Interesting that I was looking at the same memory
  location via physical and virtual addresses simultaneously and only
  virtual address showed an old code. After a few memory browsing
  operations, data at both addresses got synced to correct Thumb code.
  Sure it could be a debugger lag, but it fits nicely with other
  observations.

Do you have some ideas what could cause such behavior?

Unfortunately I don't have more time now to debug it further,
but I will try to return to this later.

[1]
https://drive.google.com/file/d/0ByfnRzd5ZYtdQWJKc1k0VmxrZlE/edit?usp=sharing

-- 
Taras Kondratiuk
