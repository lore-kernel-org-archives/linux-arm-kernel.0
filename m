From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 14 Mar 2014 11:21:56 +0100
Subject: i.MX53 suspend to RAM
Message-ID: <5322D844.50203@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Do you know how extensively the i.MX53 suspend to RAM code has been tested?

Here I am observing (with 3.13) random resume failures (once every 5 - 
50 resume cycles)

This is on custom hardware not an evaluation board so I can't rule out a 
hardware bug.

If I toggle a GPIO each side of the call to cpu_idle() in 
mx5_suspend_enter() I see that it doesn't come out of WFI.

The power consumption however seems to indicate that the problem is 
actually during the suspend.

On a successful cycle it drops from 220mA to 120mA but in the failure 
case it only drops to 150mA

Changing the code in mx5_cpu_lp_set() to
* not request the PMIC to reduce the voltage (MXC_CCM_CLPCR_VSTBY)
* not request external clock stop (MXC_CCM_CLPCR_SBYOS)

makes no difference.

The WAIT mode (used in normal idle) works fine.

Looking at the code I have a few questions too.

1) My understanding of the reference manual (18.2.6.3.1 "Stop Mode is 
Entered by the Following Procedure")
is that the TZIC_DSMINT bit should also be set.
This is done for WAIT mode in tzic_enable_wake() but is not done for 
STOP mode.
The Freescale kernel does this.
Adding code to do that does not fix the problem however.

2) I don't understand the code manipulating the 
MXC_SRPG_EMPGC[0|1]_SRPGCR registers.
These registers seem to be for the i.MX51 not the i.MX53
The i.MX53 has something similar (SRPGCx_SRPGCR) but the addresses are 
not the same.
The Freescale 2.6.35 kernel code does not use these for i.MX53
However removing the access to these registers does not fix the problem

3) The Fresscale kernel code is much more complicated, involving 
executing suspend code from IRAM that reprograms the PLLs
I can't find anything in the reference manual or the errata justifying 
this. I haven't (yet) attempted to boot the Freescale kernel
to see if it works better.


Any suggestions on how to debug this much appreciated.

Regards,

Martin
