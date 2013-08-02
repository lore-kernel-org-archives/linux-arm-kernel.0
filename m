From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 2 Aug 2013 16:21:57 +0900
Subject: [PATCH V2] ARM: allow DEBUG_UNCOMPRESS for Tegra
In-Reply-To: <CAAVeFu+=sfk0zH59GFUqt58MfTZks8qWX1+wq1Rzuh7TUCr8tQ@mail.gmail.com>
References: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
 <CAAVeFu+=sfk0zH59GFUqt58MfTZks8qWX1+wq1Rzuh7TUCr8tQ@mail.gmail.com>
Message-ID: <CAAVeFu+2dxn7ZfYfUhqjK_bkWO8Vtg2tR8e7A0jMZ6fL7Yy9Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 10:59 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Aug 2, 2013 at 2:51 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> DEBUG_UNCOMPRESS was previously disallowed for Tegra due to tegra.S's
>> use of global data that was not linked into the decompressor. Solve this
>> by declaring this symbol in tegra.S when it is being built into the
>> decompressor. For the kernel proper, leave the declaration in
>> mach-tegra/common.c as explained in the comment.
>
> Tested-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Thanks, I had to workaround this when debugging a kernel uncompression
> issue, but have not yet found the time to craft a patch.

Also on a related note there is a compilation error on
arch/arm/boot/compressed/head.S if the DEBUG macro is defined (useful
to take advantage of puts and putc for early debugging) at least on
Tegra devices. The loadsp macro definition makes use of addruart,
which has been changed to take 3 arguments since about 2 years ago
(commit 639da5ee), but loadsp still uses the 2 arguments form. I'm not
sure how this should be fixed, either by adding another argument to
loadsp (which will turn out to be useless for most implementations) or
by using an arbitrary register in the definition that uses addruart
(probably dangerous).

Alex.
