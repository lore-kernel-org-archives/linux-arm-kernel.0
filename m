From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Aug 2013 11:22:10 +0100
Subject: [Suggestion] ARM: allmodconfig: about cross compiling failure
 under i386 ubuntu.
In-Reply-To: <20130822074524.GS7656@atomide.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com>
 <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com>
Message-ID: <20130822102210.GF25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 12:45:24AM -0700, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130821 01:53]:
> > Hello Maintainers:
> > 
> > When build arm with allmodconfig under ubuntu i386 with arm-linux-
> > gnueabi-gcc 4.7, as 2.22, it report the errors.
> > 
> > Please help check, thanks (the related config file in attachment).
> 
> It seems that some make flags may need to be specified separately
> in some makefiles. See the following for some examples:
> 
> $ find arch/arm -name Makefile | xargs grep -i flags
> 
> I'm getting different errors though, I'm getting:
> 
> arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch
> 
> As probably my compiler does not support the cortex-a9 switch,
> I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.

The use of -mcpu with -march is not a good idea anyway - you either use
-mcpu= or you use -march and -mtune.

-mcpu= sets the CPU type, which specifies the instruction architecture
(iow, which instructions can be used) and instruction scheduling behaviour.

-march= sets the architecture only.  -mtune= sets the instruction
scheduling behaviour only.

So, that -mcpu= should probably be -mtune=, but if that fails due to
unrecognised instructions, the -march= parameter is wrong.

Even so, if gcc 4.3.5 doesn't support cortex-a9 as a CPU type, and we
want to support that gcc version, the setting of -mtune needs to be
conditionalised.  As it is only a scheduling hint, it's probably fine
for it to end up being omitted.
