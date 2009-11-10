From: francesco.virlinzi@st.com (Francesco VIRLINZI)
Date: Tue, 10 Nov 2009 15:00:59 +0100
Subject: [Proposal] [PATCH] generic clock framework
Message-ID: <4AF9721B.4070203@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

I'm Francesco and I work in STMicroelectronics

In the last ELC-E_2009 I spoke on a generic clock framework I'm working on
  (see 
http://tree.celinuxforum.org/CelfPubWiki/ELCEurope2009Presentations?action=AttachFile&do=view&target=ELC_E_2009_Generic_Clock_Framework.pdf).

I wrote the gcf to manage both clocks the platform_devices during a 
clock operation.

The main features are:
  - it's integrated in the LDM
  - it tracks the clock-to-clock relationship
  - it tracks the clock-to-device relationship

  - it has sysfs interface
  - - the user can navigate the clock tree under /sys/clocks/...

  - it uses the linux API (<linux/clk.h>) with some extra functions (to 
register/unregister a clock
    and other utility functions as clk_for_each())

  - it involves the platform_device and the platform_driver in the clock 
propagation.
  - - basically each clock operation is managed as a transaction which 
evolves step by step.
  - - all the clock rates are evaluated (before the clk operation is 
actually done)
  - - each platform_device can check (before the clk operation is 
actually done) the clk environment
      it will have at the end of clock operation and if required it can 
reject the operation.
  - - each clock operation is actually executed only if all the 
platform_devices accept the operation it-self


Moreover a common clock framework could be used to avoid a lot of 
duplicated and/or similar code
  just a grep of 'EXPORT_SYMBOL\(clk_enable' under arch/arm finds 22 
entries.

The patch is based on a 2.6.30 kernel also if it has a preliminary 
integration with the PM_RUNTIME
  support.

It works on our st40 (an sh4 cpu based system) no test/porting was done 
on any ARM platform.

It would be mainly a starting point for a discussion and I'm available 
to extend/fix/share it.

Regards
  Francesco
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091110/a197b928/attachment-0001.htm>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-generic-clock-framework.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091110/a197b928/attachment-0001.el>
