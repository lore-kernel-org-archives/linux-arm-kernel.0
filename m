From: riel@redhat.com (Rik van Riel)
Date: Thu, 07 Jul 2016 12:35:17 -0400
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <1467843928-29351-2-git-send-email-keescook@chromium.org>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
Message-ID: <1467909317.13253.17.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 15:25 -0700, Kees Cook wrote:
>?
> +	/* Allow kernel rodata region (if not marked as Reserved).
> */
> +	if (ptr >= (const void *)__start_rodata &&
> +	????end <= (const void *)__end_rodata)
> +		return NULL;
> 
One comment here.

__check_object_size gets "to_user" as an argument.

It may make sense to pass that to check_heap_object, and
only allow copy_to_user from rodata, never copy_from_user,
since that section should be read only.

> +void __check_object_size(const void *ptr, unsigned long n, bool
> to_user)
> +{
>?

-- 

All Rights Reversed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/f13757cc/attachment.sig>
