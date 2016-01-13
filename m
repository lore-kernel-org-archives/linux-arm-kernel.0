From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 10:20:18 +0100
Subject: [Y2038] [RFC 02/15] vfs: Change all structures to support 64 bit
 time
In-Reply-To: <20160113062716.GJ6033@dastard>
References: <1452144972-15802-1-git-send-email-deepa.kernel@gmail.com>
 <4788428.RCG4WOvRdT@wuerfel> <20160113062716.GJ6033@dastard>
Message-ID: <8960550.YnDr3xSm6r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 17:27:16 Dave Chinner wrote:
> > I think
> > it was more than that when I first looked, so it's between 0.2% and 0.3%
> > of savings in total memory, which is certainly worth discussing about,
> > given the renewed interest in conserving RAM in general.  If we want to
> > save this memory, then doing it at the same time as the timespec64 conversion
> > is the right time so we don't need to touch every file twice.
> 
> You just uttered the key words: "If we want to save this memory"
> 
> So let's stop conflating two different lines of development because
> we only actually *need* y2038k support.
> 
> The fact we haven't made timestamp space optimisations means
> that nobody has thought it necessary or worthwhile. y2038k support
> doesn't change the landscape under which we might consider the
> optimisation, so we need to determine if the benefit outweighs the
> cost in terms of code complexity and maintainability.
> 
> So separate the two changes - make the y2038k change simple and
> obviously correct first by changing everything to timespec64. Then it
> won't get delayed by bikeshedding about an optimisation of that is
> of questionable benefit.

Fine with me. I think Deepa already started simplifying the series
already. I agree that for 64-bit machines, there is no need to optimize
that code now, since we are not regressing in terms of memory size.

For 32-bit machines, we are regressing anyway, the question is whether
it's by 12 or 24 bytes per inode. Let me try to estimate the worse-case
scenario here: let's assume that we have 1GB of RAM (anything more
on a 32-bit system gets you into trouble, and if you have less, there
will be less of a problem). Filling all of system ram with small tmpfs
files means a single 4K page plus 280 bytes for the minimum inode,
so we need an additional 6MB or 12MB to store the extra timespec
bits. Probably not too bad for a worst-case scenario, but there is
also the case of storing just the inodes but no pages, and that would
be worse.

I've added the linux-arm and linux-mips lists to cc, to see if anyone has
strong opinions on this matter. We don't have to worry about x86-32 here,
because sizeof(struct timespec64) is 12 bytes there anyway, and I don't
think there are any other 32-bit architectures that have large-scale
deployments or additional requirements we don't already have on ARM.

	Arnd
