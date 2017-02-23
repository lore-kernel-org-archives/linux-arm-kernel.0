From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 23 Feb 2017 07:39:53 -0600
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <20170214025040.23955-1-stephen.boyd@linaro.org>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqJDaa+ozCTyS6M_1BP-sk3g5T2wQK+5DLTPWBKyp=AMeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 8:50 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> The 'blob' we pass into populate_properties() is marked as const,
> but we cast that const away when we assign the result of
> fdt_getprop_by_offset() to pp->value. Let's mark value as const
> instead, so that code can't mistakenly write to the value of the
> property that we've so far advertised as const.
>
> Unfortunately, this exposes a problem with the fdt resolver code,
> where we overwrite the value member of properties of phandles to
> update them with their final value. Add a comment for now to
> indicate where we're potentially writing over const data.
>
> You can see the problem here by loading an overlay dtb into
> the kernel via the request firmware helper method (not direct
> loading) and then passing that tree to the resolver on an arm64
> device. In this case, the firmware data is vmapped with KERNEL_PAGE_RO
> and the code crashes when attempting to write to the blob to update
> the phandle properties.

This problem exists with or without this patch, right?

> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>
> I was thinking perhaps it would work to store another __be32 variant
> of the phandle in each device node, but then we still have a problem
> with properties that have phandles inside them at some offset that we
> need to update. I guess the only real solution is to deep copy the
> property in that case and then save around some info to free the
> duplicated property later on?

Couldn't we just copy the overlay and free the firmware blob in this
case? That seems easier than trying to selectively copy things. We
keep the base FDT to pass to userspace and we could need that for
overlays, but not ones we load from userspace.

Rob
