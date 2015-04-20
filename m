From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Apr 2015 17:13:57 +0100
Subject: [PATCH] arm64: Implement 1-,2- byte smp_load_acquire and
 smp_store_release
In-Reply-To: <CA+55aFwgG0pNwp3ywOsaEfeArD43MoJ9VLbUYQ8DCKN30=mLOA@mail.gmail.com>
References: <1429544753-4120-1-git-send-email-a.ryabinin@samsung.com>
 <CA+55aFwgG0pNwp3ywOsaEfeArD43MoJ9VLbUYQ8DCKN30=mLOA@mail.gmail.com>
Message-ID: <20150420161357.GE1504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 05:08:37PM +0100, Linus Torvalds wrote:
> On Mon, Apr 20, 2015 at 8:45 AM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> >
> > Commit 8053871d0f7f ("smp: Fix smp_call_function_single_async() locking")
> > started to use smp_load_acquire() to load 2-bytes csd->flags.
> > That crashes arm64 kernel during the boot.
> 
> Ahh. I don't disagree with your patch, but we should just make
> csd->flags be an "int" regardless of this issue.
> 
> There is absolutely no reason to try to use 16-bit words. It doesn't
> save us any space (alignment), and it's just a *bad* idea to depend on
> any kind of atomicity of 16-bit entities. Bytes, yes. Words, yes. But
> 16-bit half-words? There's no point.
> 
> So I'll make it "unsigned int" instead of "u16".
> 
> But as said, the ARM64 patch definitely is a good idea regardless.

Sounds good to me and means I can leave the pull for a day or two to see
if any other arm64 fixes queue up.

Will
