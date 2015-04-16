From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 17:21:30 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150416133134.GC819@e104818-lin.cambridge.arm.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <E769538B-CE45-4FF3-AD2C-21B30069F0B9@caviumnetworks.com>
 <20150416133134.GC819@e104818-lin.cambridge.arm.com>
Message-ID: <2242025.Z9qPVP4zls@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 14:31:34 Catalin Marinas wrote:
> On Thu, Apr 16, 2015 at 11:33:49AM +0000, Pinski, Andrew wrote:
> > On Apr 16, 2015, at 4:19 AM, Dr. Philipp Tomsich <philipp.tomsich@theobroma-systems.com> wrote:
> > > Just for the record (and to avoid anyone wasting their time on what?s available
> > > today): we are migrating this over to option (a) now, even though we would
> > > prefer to see option (b) implemented.
> > > 
> > > If we get a consensus on (b) in the next couple of days, we?ll redo things for
> > > option (b). If not, we will have an implementation for option (a) available that
> > > we can hopefully all agree on merging.
> > 
> > I don't think either a or b are good in the long run.
> 
> b would have been my preferred option if it wasn't for the legacy apps
> support. We could also do it without much hassle in the kernel *if* we
> disabled AArch32 compat support (basically use the compat layer for
> ILP32). But I don't think choosing between AArch32 and AArch64 ILP32
> should be a build time option.

Right, that would be a clean way to support it, just one with
a significant downside of not being able to use both ILP32
ABIs concurrently on the same system.

> > There are only a few places where long should be 32bit rather than
> > 64bit. The non-time_t field of timespec is the only one I can think
> > of.
> 
> It may be the only one but we could end up with a non-compliant
> timespec. Unless we keep the tv_nsec as 32-bit long and add some
> padding, we could work around it by getting the C library to sign-extend
> such padding or we do it in a new "compat" layer in the kernel (but both
> cases imply copying the structure).
> 
> However, timerspec is included in other structures, so we'd have to
> intercept those as well. Philipp provided a list here:
> 
> http://article.gmane.org/gmane.linux.kernel/1931497

We're basically in the same boat as x32 then, and should do the
same thing on both most importantly, whatever that ends up.

However, it would be nice to get agreement on the normal
32-bit ABI for time_t and timespec first, and then use the
same thing everywhere.

	Arnd
