From: sarah.a.sharp@linux.intel.com (Sarah Sharp)
Date: Tue, 14 Jan 2014 09:07:19 -0800
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87sissopaf.fsf@natisbad.org>
References: <87eh4dot61.fsf@natisbad.org>
 <87sissopaf.fsf@natisbad.org>
Message-ID: <20140114170719.GA12126@xanatos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 10:36:56PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> arno at natisbad.org (Arnaud Ebalard) writes:
> 
> > Both with a LaCie 2.5" USB 3.0 Rugged Mini disk (powered by the port)
> > and a 3.5" SATA disk connected via an ICY DOCK MB981U3S-1S dock station
> > (external power), I can transfer huge files w/o issue but I get the
> > following when transferring small files (e.g. copy of some debian
> > directory to a folder on the disk):
> >
> > # cp -rf /lib/ /bin/ /sbin/ /opt /var/ /usr/ test/
> > [  327.130045] xhci_hcd 0000:02:00.0: xHCI host not responding to stop endpoint command.
> > [  327.137899] xhci_hcd 0000:02:00.0: Assuming host is dying, halting host.
> > [  327.144644] xhci_hcd 0000:02:00.0: HC died; cleaning up

Hmm, you're the second person to report an issue with a host dying.

> I can add the following:
> 
> 2) I just tested the copy of the small files using the ICY DOCK
> MB981U3S-1S connected to my ReadyNAS 102 *on a 3.11.7 kernel*
> and it completed successfully. 

Please try a 3.13-rc7 kernel after running `git revert 35773dac5f86`.

> 2) on current 3.13.0-rc7 kernel (w/ Bj?rn patch applied just in case), I

Which patch are you referring to?

> just transferred 40GB through a Logitec LAN-GT JU3H3 (it is based on an
> ASIX AX88179) connected to my ReadyNAS Duo v2 (NEC XHCI controller) at
> an average rate of 82MB/s. Bottom line: no issue. When I try to do the
> same on my ReadyNAS 102, I immediately get complaints:

Was the ReadyNAS 102 with the Fresco Logic host running 3.13.0-rc7 as
well?

> [  383.280429] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  383.280892] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  411.620073] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
> [  411.620750] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  411.621727] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.066651] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
> [  412.067233] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.068196] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.242708] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
> [  412.243333] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.244246] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.417956] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
> [  412.418516] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.419473] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
> [  412.545330] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred

Those messages are normal.  It just means the device transferred less
data than the host asked for, which is part of normal USB operation.

Does the dock work despite the messages?

Please send me the output of `sudo lspci -vvv -n` for the ReadyNAS 102
Fresco Logic host.

Sarah Sharp
