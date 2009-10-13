From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 13 Oct 2009 15:28:12 +0100
Subject: [PATCH] [ARM] kirkwood: combine support for openrd
	base/client?support
References: <20091009123956.GA6085@chipmunk>
	<200910091600.45161.dk-arm-linux@gmx.de>
	<20091009140508.GD6085@chipmunk>
	<alpine.LFD.2.00.0910122313090.20122@xanadu.home>
Message-ID: <scfeq6-pm4.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 9 Oct 2009, Alexander Clouter wrote:
> 
>> the struct 'openrd_ge01_data' is wrapped in 
>> #ifdef CONFIG_MACH_OPENRD_CLIENT too and only exists if you want the 
>> board support for it.  So although machine_is_openrd_client() will 
>> exist, the compiler will barf that openrd_ge01_data does not exist;
> 
> Don't put a #ifdef on it either then.
> 
Okay...

>> the alternative is to have it grumble (when you do not want the Client 
>> support) that there is an un-used struct floating about.
> 
> That shouldn't happen.  It will still be referenced by the
> 
>        if (machine_is_openrd_client())
>                kirkwood_ge01_init(&openrd_ge01_data);
> 
> and when the Client support is not configured in, then the 
> machine_is_openrd_client() is turned into a 0 which makes gcc nicely 
> optimize the unused code and static data structures away.
> 
I pondered if the compiler did that but thought as the Linux kernel is 
littered with ifdef's anyway, a few more cannot hurt :)

>> I was under the impression the latter is considered worse than the 
>> former, I personally am not bothered either way.
> 
> Did you try the later?
> 
Nope, but I just have now and you are quite right.  All ifdef's nuked 
from orbit.

>> > Additionally it would be nice, if you could integrate the i2c / pcie 
>> > init in your patch? Please see Simons patch at:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001950.html
>> > 
>> I knew someone was going to say that :)  Will do though, so 'watch this 
>> space'.
> 
> Being a separate issue, this probably should remain a separate patch.  
> My position is that the missing PCI init call could go upstream now 
> whereas the consolidation patch would need to wait for the next merge 
> window.
> 
That's fine with me, I was just throwing the patch out there to see how 
people felt about the consolidation and also as since August[1] the 
OpenRD Client had not been mentioned on the mailing list.

Cheers

[1] http://lkml.org/lkml/2009/8/19/115

-- 
Alexander Clouter
.sigmonster says: Memory fault -- brain fried
