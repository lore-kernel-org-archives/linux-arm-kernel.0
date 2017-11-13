From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Mon, 13 Nov 2017 14:19:54 +0530
Subject: [PATCH] kdump: print a message in case crashkernel size parsing
 resulted in zero bytes
In-Reply-To: <20171113054311.GA4971@dhcp-128-65.nay.redhat.com>
References: <20171113054311.GA4971@dhcp-128-65.nay.redhat.com>
Message-ID: <a8a5d2ae-579e-262c-4231-49ab967b0108@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Cc: arm kernel mailing list for wider distribution

On 11/13/2017 11:13 AM, Dave Young wrote:
> In parse_crashkernel_mem, it silently return in case we get zero
> bytes in the parsing function.  It is useful for debugging for
> adding a warning message especially sometimes kernel can not boot
> up correctly.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kernel/crash_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- linux-x86.orig/kernel/crash_core.c
> +++ linux-x86/kernel/crash_core.c
> @@ -108,7 +108,8 @@ static int __init parse_crashkernel_mem(
>                  return -EINVAL;
>              }
>          }
> -    }
> +    } else
> +        pr_warn("crashkernel size resulted in zero bytes\n");
>
>      return 0;
>  }
>
This is a useful change as finding this debug message in the boot logs allows better debug of crashkernel related issues.

However I have one minor point:

- The comment above 'parse_crashkernel_mem' currently mentions:
  * The function returns 0 on success and -EINVAL on failure.
  */

- I am wondering if we hit the WARNING case where the crashkernel size resulted in 0 bytes, then should we still be returning 0 from this function. Or, should this be replaced with 'return -EINVAL'.

- If not, can we atleast update the comment above this function to better document the return values and where having a 'return 0' should be ok, even if crashkernel size resulted in 0 bytes.

Regards,
Bhupesh
