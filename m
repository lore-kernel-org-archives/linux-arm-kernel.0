From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 15 Jan 2014 09:59:10 +0000
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87bnzekz5l.fsf@natisbad.org>
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnaud Ebalard
> Sent: 14 January 2014 21:54
> To: Sarah Sharp
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Bj?rn Mork
> Subject: Re: [BUG] FL1009: xHCI host not responding to stop endpoint command.
> 
> Hi Sarah,
> 
> Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> 
> >> I can add the following:
> >>
> >> 2) I just tested the copy of the small files using the ICY DOCK
> >> MB981U3S-1S connected to my ReadyNAS 102 *on a 3.11.7 kernel*
> >> and it completed successfully.
> >
> > Please try a 3.13-rc7 kernel after running `git revert 35773dac5f86`.
> 
> I tried current 3.13.0-rc8 w/ 35773dac5f86 reverted and the result is
> the same:

That patch only affects an error code and stops the fs code retrying for ever.

Does everything work if you comment out the code in xhci-ring.c that adds
NOP TRBs to the ring end in order to stop the LINK TRB appearing in the middle
of a TB.
The ethernet code needs it, but the disk transfers are (probably) aligned
such that they don't.

If that all works I'll look at writing a patch that either doesn't use NOPs
or checks the alignment of all the fragments.

	David
