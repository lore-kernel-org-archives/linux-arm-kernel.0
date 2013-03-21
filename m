From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Mar 2013 15:41:32 -0600
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321221523.7ede6ccc@skate>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com>
 <20130321221523.7ede6ccc@skate>
Message-ID: <20130321214132.GB8431@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:15:23PM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Thu, 21 Mar 2013 14:55:45 -0600, Jason Gunthorpe wrote:
> 
> > Or, better, locate all the internal registers above 8G and use
> > contiguous DRAM mapping from 0 -> 8GB
> 
> I see two potential issues with this idea:
> 
>  *) It only works when LPAE is enabled, so we would have to have
>     different internal register addresses depending on whether LPAE is
>     enabled or not. Probably not impossible, but not very
>     straightforward either.

Ideally the internal register space address would come from the DT -
we are getting very close to that on Marvell, I think.. Things like
earlyprintk should ideally early parse the DT, harder I know :(

>  *) It would require Linux to change the internal registers address
>     (for now the kernel relies on the bootloader). The problem is that
>     we can't do it early enough to preserve the earlyprintk
>     functionality. Maybe you have suggestions on how to achieve that?

I can't forsee how Linux could do this reprogramming - not only do you
have to move the registers, you'd also have to reprogram the DRAM
bases, while running from the DRAM. Not only does that have to be done
early, but the DT would need to describe the DRAM ranks, and the code
would have to parse it.. On top of that it would have to be very
careful not to wack any DRAM that has already been touched by the
kernel.. Tricky stuff :)

Jason
