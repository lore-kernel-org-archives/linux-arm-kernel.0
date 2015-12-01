From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Dec 2015 16:19:44 +0000
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <565DC5A9.2010305@suse.cz>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk>
 <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk>
 <565C6DE9.2020302@suse.com> <565DC5A9.2010305@suse.cz>
Message-ID: <20151201161944.GX8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 05:07:05PM +0100, Michal Marek wrote:
> On 2015-11-30 16:40, Michal Marek wrote:
> > On 2015-11-30 16:32, Russell King - ARM Linux wrote:
> >> On Mon, Nov 30, 2015 at 04:11:16PM +0100, Michal Marek wrote:
> >>> On 2015-11-26 00:47, Russell King - ARM Linux wrote:
> >>>> Do we have any resolution on these programs which modify the object
> >>>> files in-place, rather than breaking any hard-links which may be
> >>>> present (eg, as a result of using ccache in hard-link mode) ?
> >>>
> >>> Good point, but I do not think anybody is using CCACHE_HARDLINK with the
> >>> kernel.
> >>
> >> That's wrong then, because I've been using it for a very long time with
> >> my nightly builds. :)  Therefore, there is somebody!
> > 
> > OK.
> 
> So, both recordmcount and the new recordudiv program are idempotent.
> They check if the to-be-added section is already present and do nothing.

They hardly "do nothing", as the (eg) recordmcount plasters the build
log with warnings.  A solution to that would be to make recordmcount
silent if the section is already present.

> So the result is correct even with CCACHE_HARDLINK, just the
> intermediate file might be incorrect. If this still is considered an
> issue, I suggest clearing CCACHE_HARDLINK when using any of these
> postprocessors, so as not to penalize other use cases.

Another solution would be to have the top level make file unset the
CCACHE_HARDLINK environment variable if any of the options which enable
in-place editing of object files is enabled.  Looking at the ccache
code, the environment variable has to be deleted from the environment
to turn off the option - and I'm not sure whether make can delete
environment variables.  It certainly can override them, but I see
nothing in the info pages which suggests that environment variables
can be deleted by a makefile.

However, doing it outside of the kernel build system is likely error
prone especially as the kernel configuration options change and/or
their effect changes.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
