From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Nov 2011 13:08:26 -0700
Subject: [PATCH 1/2] OMAP2+: DMA: Workaround for invalid source
	position
In-Reply-To: <2603119.amz7RjSE3J@barack>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
	<1320070817-9638-2-git-send-email-peter.ujfalusi@ti.com>
	<20111103212756.GZ31337@atomide.com> <2603119.amz7RjSE3J@barack>
Message-ID: <20111104200826.GE31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* P?ter Ujfalusi <peter.ujfalusi@ti.com> [111104 02:00]:
> On Thursday 03 November 2011 14:27:56 Tony Lindgren wrote:
> > 
> > Should these tests be done only after the errata re-read for both
> > src and dst patches? Otherwise the errata will not be handled?
> 
> Yes that might be a good idea.
> I was trying to locate the original errata description for DMA_ERRATA_3_3, but 
> it does not exist, or at least I can not find it. This only been mentioned in 
> the kernel's comment.

Seems it got added with commit d3c9be2f.

> I'm not sure when this DMA_ERRATA_3_3 would have been in force. My guess would 
> be that if someone wants to read the src/dst position right after the channel 
> is disabled, but what would we expect it to return when the channel has been 
> disabled?

No idea.. Or read it after stopping it?

> I mean what is the reasonable src/dst for a disabled channel? 0 is as good as 
> any other number, probably the programmed start of the DMA transfer would be 
> my best bet.
> I think the errata description for DMA_ERRATA_3_3 is not correct, and it is in 
> fact to handle the case I'm also handling: Before the first DMA request the 
> CDAC is 0 (since we configured it to be), the CSAC contains _something_ (most 
> of the time 0, but can be random number).
> In some situation re-reading the src/dst position will give enough time to 
> receive the first DMA request, which will update CDAC/CSAC registers.

Yeah could be since the handling is just an immediate re-read of the register..
 
> What do you think?

Probably the safest thing to do is move your check after the re-read test
in case there's more to the ERRATA_3_3.

Regards,

Tony
