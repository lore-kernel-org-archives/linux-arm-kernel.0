From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 13 Mar 2014 14:51:56 -0700
Subject: [PATCH v5 09/11] arm: add support for reserved memory defined by
 device tree
In-Reply-To: <20140313213636.GR18529@joshc.qualcomm.com> (Josh Cartwright's
 message of "Thu, 13 Mar 2014 16:36:36 -0500")
References: <1392985527-6260-1-git-send-email-m.szyprowski@samsung.com>
 <1392985527-6260-10-git-send-email-m.szyprowski@samsung.com>
 <CAGa+x856+YyJ-vyfGoFAKmsqwKD+=Wh0-TT_mAaPStOXjd8eSQ@mail.gmail.com>
 <20140313213636.GR18529@joshc.qualcomm.com>
Message-ID: <7h8usdlqbn.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh Cartwright <joshc@codeaurora.org> writes:

> On Thu, Mar 13, 2014 at 01:46:50PM -0700, Kevin Hilman wrote:
>> On Fri, Feb 21, 2014 at 4:25 AM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>> > Enable reserved memory initialization from device tree.
>> >
>> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> 
>> This patch has hit -next and several legacy (non-DT) boot failures
>> were detected and bisected down to this patch.  A quick scan looks
>> like there needs to be some sanity checking whether a DT is even
>> present.
>
> Hmm.  Yes, the code unconditionally calls of_flat_dt_scan(), which will
> gladly touch initial_boot_params, even though it may be uninitialized.
> The below patch should allow these boards to boot...
>
> However, I'm wondering if there is a good reason why we don't parse the
> /reserved-memory nodes at the right after we parse the /memory nodes as
> part of early_init_dt_scan()...
>
> Thanks,
>   Josh
>
> --8<--
> Subject: [PATCH] drivers: of: only scan for reserved mem when fdt present
>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>

This gets legacy boot working again.  Thanks.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin

> ---
>  drivers/of/fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 510c0d8..501bc83 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -557,6 +557,9 @@ static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
>   */
>  void __init early_init_fdt_scan_reserved_mem(void)
>  {
> +	if (!initial_boot_params)
> +		return;
> +
>  	of_scan_flat_dt(__fdt_scan_reserved_mem, NULL);
>  	fdt_init_reserved_mem();
>  }
