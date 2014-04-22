From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 19:36:39 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <alpine.LFD.2.11.1404221341130.980@knanqh.ubzr>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com> <535639EE.7040102@linaro.org>
 <20140422170520.GB23955@obsidianresearch.com>
 <alpine.LFD.2.11.1404221341130.980@knanqh.ubzr>
Message-ID: <20140422183639.GY24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 01:55:16PM -0400, Nicolas Pitre wrote:
> We do not want people in general to have PLAT_PHYS_OFFSET defined and
> CONFIG_ARM_PATCH_PHYS_VIRT disabled.  In fact a huge effort has been 
> deployed to go the exact opposite way over the last few years.
> 
> There are special cases where CONFIG_ARM_PATCH_PHYS_VIRT needs to be 
> turned off for example.  But those are specialized configurations and 
> they should be the exception not the norm.  And you should be knowing 
> what you're doing in those cases.
> 
> So I doubt it is worth complexifying the linker script for something 
> that is meant to be the exception, _especially_ if this is for some 
> debugging environment purposes.  You may just adjust some setting in 
> your environment or do a quick kernel modification locally instead.  
> And if you don't know what to modify then you're probably lacking the 
> necessary qualifications to perform that kind of kernel debugging in the 
> first place.
> 
> Making the patch available on a mailing list is fine.  If it is useful 
> to someone else then it'll be found.  But I don't think this is useful 
> upstream.

Also, let's not forget that it the ELF file can be modified after the
kernel build:

$ vmlinux=your-vmlinux-file
$ newlma=lma-for-your-platform
$ arm-linux-objcopy $(
  arm-linux-objdump -h ${vmlinux} |
  grep -B1 'LOAD' | \
  sed -nr 's/^[ 0-9]*[0-9] ([^ ]*).*/--change-section-lma \1+${newlma}/p') \
  ${vmlinux} ${vmlinux}-${newlma}

(It would be nice if objcopy could be told "change any section with _this_
attribute".)

The nice thing about this is that you can keep ARM_PATCH_PHYS_VIRT enabled
and not have to change the code in any way - you just fix up the headers on
the ELF file.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
