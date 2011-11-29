From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 29 Nov 2011 11:11:57 -0700 (MST)
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <4ED50600.8070607@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com>
 <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com>
 <alpine.DEB.2.00.1111261906010.6289@utopia.booyaka.com>
 <4ED50600.8070607@ti.com>
Message-ID: <alpine.DEB.2.00.1111291053250.6289@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Nov 2011, Cousson, Benoit wrote:

> On 11/27/2011 3:07 AM, Paul Walmsley wrote:
> 
> > So just out of curiosity, do those SYSCONFIG registers in the STM address
> > space apply to the entire DEBUGSS, or just the STM IP block?
> 
> The STM IP is the only one to have the TI generic wrapper to be compliant with
> TI standards.
> But in term of PRCM, there is only one IP, the DEBUGSS.
> There are probably a bunch of internal clock management inside it that are not
> exposed to PRCM.
> 
> The confusing part is that in theory all these entries can be accessed by the
> same OCP port, and should potentially have this flags.
> The point is that for the moment, we are mainly using that flag to get the
> SYSCONFIG.
> We already discussed that, but I think we should modify this flag to highlight
> the SYSCONFIG / SYSSTATUS availability.
> Maybe with something like ADDR_SYSCONFIG?
> 
> Any thought?

Well, the ADDR_TYPE_RT flag in this hwmod would indicate the address space 
of the DEBUGSS's OCP header registers, not the MIPI STM's OCP header 
registers.

So if the MIPI STM's OCP header registers also control the entire DEBUGSS 
power management, then the current layout makes sense.  Otherwise, the 
MIPI STM should be created as a separate hwmod.

It appears to me that the DEBUGSS has no OCP header registers of its own.  
Upon reflection, rather than creating a macro hwmod for the DEBUGSS, it 
seems to make more sense to add hwmods for its two internal interconnects, 
then to create another hwmod for the MIPI STM device.


- Paul
