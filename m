From: keescook@chromium.org (Kees Cook)
Date: Wed, 21 Sep 2016 16:49:29 -0700
Subject: [PATCHv2] arm64: Correctly bounds check virt_addr_valid
In-Reply-To: <1474496704-30541-1-git-send-email-labbott@redhat.com>
References: <1474496704-30541-1-git-send-email-labbott@redhat.com>
Message-ID: <CAGXu5jKrHyJ4mgcoXxbhns4kFP4sWn-9dAOn9bP3pzXLhs9kuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 3:25 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> virt_addr_valid is supposed to return true if and only if virt_to_page
> returns a valid page structure. The current macro does math on whatever
> address is given and passes that to pfn_valid to verify. vmalloc and
> module addresses can happen to generate a pfn that 'happens' to be
> valid. Fix this by only performing the pfn_valid check on addresses that
> have the potential to be valid.
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Properly parenthesize macro arguments. Re-factor to common macro.
>
> Also in case it wasn't clear, there's no need to try and squeeze this
> into 4.8. Hardened usercopy should have all the checks, this is just for
> full correctness.

After this lands for 4.9, I should likely drop the checks that are in
hardened usercopy? That'll speed things up ever so slightly, and will
let us catch other architectures that have a weird
virt_addr_valid()...

-Kees

-- 
Kees Cook
Nexus Security
