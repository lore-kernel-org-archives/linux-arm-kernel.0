From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jan 2016 19:34:09 +0000
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A27C00.5060004@free.fr>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk>
 <56A27C00.5060004@free.fr>
Message-ID: <20160122193408.GE19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 07:59:12PM +0100, Mason wrote:
> On 22/01/2016 18:48, Russell King - ARM Linux wrote:
> > No, you _must_ use the correct functions to access userspace.
> > Userspace accesses are marked in a special way that allows the kernel
> > to fix up non-present pages.
> 
> Do you mean calling might_fault() ?

No, I explicitly listed the functions you should be using in my
original reply.

> > Normal accesses may appear to work but
> > will eventually oops the kernel when the page is unmapped or is marked
> > read-only and you try to write to it.
> 
> I'll have to check again how the code was before I made
> my silly changes, but it's been in production for years,
> and we've never had any problem in that module...
> (But I suppose something broken can appear to work for
> months or years.)
> 
> > Please don't think of using __copy_from_user() et.al. either - those
> > are there for code which knows what it's doing and has pre-validated
> > the accesses.
> 
> I do call access_ok() before doing the copy.

It's possible to use access_ok() + __copy_from_user(), but that's
really frowned upon because it's _very_ easy to get it wrong - and
then you have a security bug.

> > Drivers and platform code should use copy_from_user()/copy_to_user()
> > to block-copy data to/from userspace, and get_user()/put_user() to
> > copy individual bytes, shorts and int/longs.  (It doesn't matter
> > who you are, that's the official guidance.)
> 
> The problem is that the kernel module's API is already set
> in stone, and it requires block copies with specific access
> sizes, e.g. block_copy8, block_copy16, block_copy32.

Rather than making these statements, you need to explain what, how
and why.

What do these "block_copy8, block_copy16, block_copy32" functions
do?  Does the "8", "16" and "32" refer to the access size?  Why do
they need to make accesses to userspace using these specific sizes?
What causes this restriction?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
