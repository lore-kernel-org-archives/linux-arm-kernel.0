From: keescook@chromium.org (Kees Cook)
Date: Mon, 24 Aug 2015 11:51:04 -0700
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <20150824184709.GE7557@n2100.arm.linux.org.uk>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <CAGXu5jJ8KOoVkx99rrajEEx77Z6zO4TzCXaXkB74zv9QQFuJFw@mail.gmail.com>
 <20150824184709.GE7557@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jJFf+9OgnGt_Cx5Q-Pht7LAT7M-sSXftTDORybrr+SECg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:47 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 24, 2015 at 11:06:52AM -0700, Kees Cook wrote:
>> On Fri, Aug 21, 2015 at 6:30 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Aug 18, 2015 at 02:42:44PM -0700, Jeffrey Vander Stoep wrote:
>> >> List poison pointer values point to memory that is mappable by
>> >> userspace. i.e. LIST_POISON1 = 0x00100100 and LIST_POISON2 =
>> >> 0x00200200. This means poison values can be valid pointers controlled
>> >> by userspace and can be used to exploit the kernel as demonstrated in
>> >> a recent blackhat talk:
>> >> https://www.blackhat.com/docs/us-15/materials/us-15-Xu-Ah-Universal-Android-Rooting-Is-Back-wp.pdf
>> >>
>> >> Can these poison values be moved to an area not mappable by userspace
>> >> on 32 bit ARM?
>> >
>> > As was discussed privately before your message, both Catalin and myself
>> > agreed that this is not possible, and I proposed alternatives which were
>> > feasible.
>> >
>> > I have now implemented the domain access alternative which I mentioned
>> > during that discussion, which is suitable for all non-LPAE setups, which
>> > has the effect of blocking almost all implicit kernel accesses to
>> > userspace, thereby substantially reducing the possibility for an attack
>> > similar to that given in the above paper.
>>
>> What's the right solution for LPAE setups?
>
> That's something which Catalin indicated that he'll work on.  However,
> he said in a public email last week that he won't be around for a while.
>
> So, I have no immediate solution for LPAE - it looks like LPAE will
> require switching the page tables on kernel entry or exit, and again
> each and every time we want to perform a userspace access.  How this
> is done is not something that has been discussed, and neither do we
> yet know how expensive this will be.  There are a number of places in
> the kernel where a large number of get_user()s or put_user()s follow
> one after each other, which necessitates switching back and forth
> multiple times.  We may need to address some of those areas by
> converting them to copy_(to|from)_user().

By the way, have you looked at grsecurity's implementation of these
protections? They've been using domains for a while now, and I think
have an LPAE solution as well.

The original description of the work was here:
https://forums.grsecurity.net/viewtopic.php?f=7&t=3292

-Kees

-- 
Kees Cook
Chrome OS Security
