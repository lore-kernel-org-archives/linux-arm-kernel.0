From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 13:06:12 +0100
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <20150821173242.GD16410@e104818-lin.cambridge.arm.com>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <20150821173242.GD16410@e104818-lin.cambridge.arm.com>
Message-ID: <20150824120612.GY7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 06:32:42PM +0100, Catalin Marinas wrote:
> On Fri, Aug 21, 2015 at 02:30:43PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Aug 18, 2015 at 02:42:44PM -0700, Jeffrey Vander Stoep wrote:
> > > List poison pointer values point to memory that is mappable by
> > > userspace. i.e. LIST_POISON1 = 0x00100100 and LIST_POISON2 =
> > > 0x00200200. This means poison values can be valid pointers controlled
> > > by userspace and can be used to exploit the kernel as demonstrated in
> > > a recent blackhat talk:
> > > https://www.blackhat.com/docs/us-15/materials/us-15-Xu-Ah-Universal-Android-Rooting-Is-Back-wp.pdf
> > > 
> > > Can these poison values be moved to an area not mappable by userspace
> > > on 32 bit ARM?
> > 
> > As was discussed privately before your message, both Catalin and myself
> > agreed that this is not possible, and I proposed alternatives which were
> > feasible.
> 
> Nice to see these patches so quickly. However, I'll be away for the next
> ~12 days, so I won't be able to review them.

That'll be after the merge window opens, so I'll drop them into
linux-next now - they've already been through Olof's builder.  I've
already tweaked one patch to ensure that it doesn't cause build errors
with !MMU platforms.

I see that there's some boot failures reported via the mail interface
to kernelci.org, but I've no idea what they are as kernelci.org is not
elinks-compatible (kernelci.org makes use of javascript.)  So I'm not
going to care about them until someone reports the failures in a form
I can read.

In any case, kernelci.org seems to be random in terms of which platforms
get a boot test - two builds one after each other show initally 373
boots tested, and then only 195 despite the second build not failing
any ARM targets.

kernelci.org is not useful to me in this state, so I shall go purely
on Olof's build system which gave me a successful build and mostly
successful boot.  (Even with Olof's boot system, it's difficult to
tell what is a real failure and what is a transient failure - provoking
the build system to run the same build twice often results in different
boot results...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
