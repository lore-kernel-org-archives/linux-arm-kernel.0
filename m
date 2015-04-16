From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Apr 2015 14:31:34 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <E769538B-CE45-4FF3-AD2C-21B30069F0B9@caviumnetworks.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150415100153.GA11626@localhost> <2243754.JW5bGY74bP@wuerfel>
 <20150415153800.GG22741@localhost>
 <C342B5CD-D1E2-4364-B99E-C85470A869BB@theobroma-systems.com>
 <20150415172219.GE26099@e104818-lin.cambridge.arm.com>
 <552EE560.9070205@suse.de>
 <20150416110325.GB819@e104818-lin.cambridge.arm.com>
 <09A21550-3538-4A8E-AB12-A9A516D3E866@theobroma-systems.com>
 <E769538B-CE45-4FF3-AD2C-21B30069F0B9@caviumnetworks.com>
Message-ID: <20150416133134.GC819@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 11:33:49AM +0000, Pinski, Andrew wrote:
> On Apr 16, 2015, at 4:19 AM, Dr. Philipp Tomsich <philipp.tomsich@theobroma-systems.com> wrote:
> > Just for the record (and to avoid anyone wasting their time on what?s available
> > today): we are migrating this over to option (a) now, even though we would
> > prefer to see option (b) implemented.
> > 
> > If we get a consensus on (b) in the next couple of days, we?ll redo things for
> > option (b). If not, we will have an implementation for option (a) available that
> > we can hopefully all agree on merging.
> 
> I don't think either a or b are good in the long run.

b would have been my preferred option if it wasn't for the legacy apps
support. We could also do it without much hassle in the kernel *if* we
disabled AArch32 compat support (basically use the compat layer for
ILP32). But I don't think choosing between AArch32 and AArch64 ILP32
should be a build time option.

> There are only a few places where long should be 32bit rather than
> 64bit. The non-time_t field of timespec is the only one I can think
> of.

It may be the only one but we could end up with a non-compliant
timespec. Unless we keep the tv_nsec as 32-bit long and add some
padding, we could work around it by getting the C library to sign-extend
such padding or we do it in a new "compat" layer in the kernel (but both
cases imply copying the structure).

However, timerspec is included in other structures, so we'd have to
intercept those as well. Philipp provided a list here:

http://article.gmane.org/gmane.linux.kernel/1931497

> The rest are valid and good idea to stay as 64bit. Including the
> limits. I think this whole discussion should have happened over a year
> ago. And I thought c was decided back then. I had even implemented a
> originally and then asked to move over to c. So I am a bit upset now
> we are making this kind of huge changes to the abi a year after the
> original posting of the patch. 

Well, I said it already, this ABI is *not* a kernel-only decision, so
without further feedback from the user space world I'm not merging any
patches. I thought I was pretty clear 6-7 months ago but there wasn't
any reply until February:

http://article.gmane.org/gmane.linux.kernel/1800005

> Also why does it takes over a year to accept patches into the linux
> kernel when it takes much less time to make huge changes into gcc

Original developers being unresponsive could be a reason ;) (see the
above post unanswered for few months).

> (pointer plus is an example which took only a few months to accept and
> it was an infrastructure change and this is not even an infrastructure
> change). 

ILP32 is an ABI that we have to leave with for many years. We have to
try hard to get it right rather than rush merging the patches (once
merged, we can't break the ABI later).

-- 
Catalin
