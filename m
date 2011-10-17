From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Oct 2011 10:17:49 +0100
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
In-Reply-To: <20111017084421.GD21648@n2100.arm.linux.org.uk>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20111008192621.GA28049@pengutronix.de>
	<20111008220722.GG25689@n2100.arm.linux.org.uk>
	<20111013090609.GT577@pengutronix.de>
	<20111017084421.GD21648@n2100.arm.linux.org.uk>
Message-ID: <20111017091749.GF21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 09:44:21AM +0100, Russell King - ARM Linux wrote:
> http://www.arm.linux.org.uk/developer/machines/download.php?q=1
> 
> will be the exact file if I were to update it right now (that's the
> URL it's retrieved from.)
> 
> One of the problems we now have is that I no longer have visibility
> of platforms going into mainline (I only find out after they've been
> merged into mainline), so I've no way to update the database with
> that information before I do an update - my information will be up
> to three months out of date.  This in turn means that the 12 month
> grace period can expire and the entries deleted from the merged file
> _after_ they've been merged and queued up elsewhere.
> 
> As I've already said, this has now become one very big unmanagable
> problem.  It needs someone to spend a lot of time at each update
> manually verifying every addition and removal (and kicking those
> people who botch their entries up - which given my interpretation of
> the data protection act means it can only be me).
> 
> I haven't committed an update since August, and at this point in the
> cycle, I'm not going to before this merge window - the risks of breaking
> something already merged or queued up are just too great to consider
> doing so now.
> 
> Longer term, I don't have an answer to this problem - I don't think
> there is a workable answer to a distributed development model with
> a centralized ID database with a grace period on 'unused' entries.

And while we're discussing this issue...

+v7pxa_dt               MACH_V7PXA_DT           V7PXA_DT                3794
+v7mmp_dt               MACH_V7MMP_DT           V7MMP_DT                3795

Why do we have DT-based IDs being registered?  DT does not use machine
IDs in any shape or form.  For DT platforms, machine_is_xxx() must not
be used because it's meaningless.

#define DT_MACHINE_START(_name, _namestr)               \
static const struct machine_desc __mach_desc_##_name    \
 __used                                                 \
 __attribute__((__section__(".arch.info.init"))) = {    \
        .nr             = ~0,                           \
        .name           = _namestr,

Note the .nr = ~0 there.
