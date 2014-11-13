From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 11:53:19 +0100
Subject: [PATCHv3 2/5] ARM: mvebu: disable I/O coherency on non-SMP
 situations on Armada 370/375/38x/XP
In-Reply-To: <20141113111730.705f9ca1@free-electrons.com>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <5650402.1KVMxKcjQn@wuerfel> <20141113111730.705f9ca1@free-electrons.com>
Message-ID: <1582668.V5SXEARn2a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 11:17:30 Thomas Petazzoni wrote:
> On Thu, 13 Nov 2014 11:10:07 +0100, Arnd Bergmann wrote:
> 
> > Seems fine to me. I was hoping to solve this with the introduction
> > of the CONFIG_ARCH_MULTIPLATFORM_STRICT or CONFIG_BROKEN_MULTIPLATFORM
> > setting that would allow us to have a compile-time setting to make it
> > work on UP (while possibly breaking or slowing down other machines
> > in a multiplatform kernel), but Russell didn't like the idea.
> 
> Right. Unfortunately, I don't currently see a good way of handling such
> a case, other than having the C code at some point in the
> initialization re-create all the page tables that were set up by the
> assembly code. The basic problem here is that I need access to an
> information located in the Device Tree at a moment where the DT isn't
> available. So there are two options: 1/ make the DT available earlier,
> but it really seems impractical to manipulate the DT in the
> early assembly code, or 2/ make sure that the initialization done in
> the assembly code can be overridden later.
> 
> What do you think?

IIRC there is still an unsolved problem on mach-keystone that is somewhat
related, they also have to change the page tables and the current method
appears to be racy. Once that is solved, you might be able to do 2.

The approach I had in mind was much simpler, introducing a compile-time
option that hardcodes the behavior you need for Armada-370 when set,
knowing that you should not set that on any kernel that is supposed to
run on other platforms.

	Arnd
