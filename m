From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Thu, 31 Jul 2014 14:19:20 +0000
Subject: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <20140731135652.GD4375@pd.tnic>
References: <9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl>
 <20140731113324.GB4375@pd.tnic>
 <808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl>
 <20140731131702.GC4375@pd.tnic>
 <a366b39c-b354-4d90-8b1e-71e74ab77cf3@BL2FFO11FD011.protection.gbl>
 <20140731135652.GD4375@pd.tnic>
Message-ID: <299a13fb-f442-4ebf-b0fc-d09d0dfc536d@BN1AFFO11FD019.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

>-----Original Message-----
>From: Borislav Petkov [mailto:bp at alien8.de]
>Sent: Thursday, July 31, 2014 7:27 PM
>To: Michal Simek
>Cc: Punnaiah Choudary Kalluri; dougthompson at xmission.com;
>robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
>ijc+devicetree at hellion.org.uk; Kumar Gala; Rob Landley;
>devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-
>edac at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org; Punnaiah Choudary; Anirudha Sarangi; Srikanth
>Vemula
>Subject: Re: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr
>ecc controller
>
>On Thu, Jul 31, 2014 at 03:36:35PM +0200, Michal Simek wrote:
>> Mixing functions for two/more different controller seems to me
>> really messy.
>
>Just stating that something is "really messy" without giving at least
>one technical reason for it is not going to get you any further. So let
>me give you mine:
>
>I think it is not messy because one file contains all the EDAC code for
>that system. Like every other system out there uses one EDAC driver.
>Everything is nicely contained in one place, any communication between
>the two memory controllers is done internally in that driver.
>
>Having two drivers would make that much more complicated. But hey, if
>you want to make your life more complicated because it is not enough
>complicated, feel free to do so. Just make sure you don't impose any
>restrictions on the rest of the subsystem.

Here we are also considering reusability of the driver. Let's say if some other
SOC contains Synopsys ddr controller then this driver can be reused. In this case,
Having separate driver would be good. But as you said in your previous comment,
We will talk about this later. 

Thanks,
Punnaiah
>
>> > -ENOPARSE for this sentence.
>>
>> I meant by this this scenario - please correct me if I am completely wrong
>> because I am not playing with this subsystem. My expectation is that
>> memory controller number should be same all the time.
>>
>> two memory controllers with the same edac driver.
>>
>> Normal calling sequence:
>> X probe - number 0
>> Y probe - number 1
>>
>> Different order/name (I think order is taken at the first place)
>> in DTS should caused that X will have number 1 and Y number 0.
>>
>> Another scenario:
>> two controllers and one with external gpio reset for example.
>>
>> X probe is called but gpio controller is not ready and gpio driver returns
>> -EPROBE_DEFER then Y probe is called and get number 0. Then X probe is
>called
>> again and get number 1.
>
>Right, since you have a heterogeneous design, you'd need to account
>for all that in your driver and deal with probing order. Like having a
>way to ask a controller what kind of a controller it is and so on. I'm
>afraid I don't know anything about your design to be of more help there.
>
>However, doing this in one <name>_edac.c file is almost trivial than
>doing it with two separate drivers. Unless you don't need to do any
>meaningful communication between the PS and PL. Then it doesn't matter.
>
>If I were you, I'd spend a more time on a proper design now so that all
>my work later is easy. Adding two drivers just because it seems messy is
>not a very good idea. What I would do is analyze all my use cases and
>come up with a proper design then. But this is just me.
>
>HTH.
>
>--
>Regards/Gruss,
>    Boris.
>
>Sent from a fat crate under my desk. Formatting is fine.
>--
