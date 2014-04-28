From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Apr 2014 11:21:32 +0200
Subject: [PATCH RFC 3/8] component: add support for component match array
In-Reply-To: <E1WeBba-0002Gd-9p@rmk-PC.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <E1WeBba-0002Gd-9p@rmk-PC.arm.linux.org.uk>
Message-ID: <20140428092131.GE19455@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 12:01:58AM +0100, Russell King wrote:
> Add support for generating a set of component matches at master probe
> time, and submitting them to the component layer.  This allows the
> component layer to perform the matches internally without needing to
> call into the master driver, and allows for further restructuring of
> the component helper.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/component.c  | 118 ++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/component.h |   7 +++
>  2 files changed, 122 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
[...]
> +void component_match_add(struct device *dev, struct component_match **matchptr,
> +	int (*compare)(struct device *, void *), void *compare_data)
> +{
> +	struct component_match *match = *matchptr;
> +
> +	if (IS_ERR(match))
> +		return;
> +
> +	if (!match || ++match->num == match->alloc) {
> +		size_t new_size = match ? match->alloc + 16 : 15;

Doesn't this allocate prematurely? If component_match_add() is called on
the final component of a master, then match->num will be incremented to
it's final value. If that matches match->alloc, then things are just
fine, aren't they? No need to allocate another 16 entries.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/44ea3b9b/attachment.sig>
