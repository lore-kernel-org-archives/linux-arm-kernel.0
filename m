From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 12 Dec 2016 15:48:17 +1000
Subject: [PATCH 4/4] ARM: versatile: support configuring versatile machine
 for no-MMU
In-Reply-To: <20161209202901.GQ14217@n2100.armlinux.org.uk>
References: <1481093992-30520-1-git-send-email-gerg@uclinux.org>
 <1481093992-30520-2-git-send-email-gerg@uclinux.org>
 <CACRpkdZywn46QbnvKcN-jkt43Vf+GBSNQkLgnnNg-DC-8aSO5w@mail.gmail.com>
 <58481DD1.6090606@arm.com> <20161209202901.GQ14217@n2100.armlinux.org.uk>
Message-ID: <48483769-1fef-86a6-feff-d98981cfb330@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/16 06:29, Russell King - ARM Linux wrote:
> On Wed, Dec 07, 2016 at 02:33:53PM +0000, Vladimir Murzin wrote:
>> Hi Linus,
>>
>> On 07/12/16 14:11, Linus Walleij wrote:
>>> Another target I had in mind was the Integrator which
>>> incidentally supports a bunch of the old noMMU core
>>> tiles where we can swap in an ARM946, which I guess
>>> could work with this?
>>
>> Do you mind trying my "Allow NOMMU for MULTIPLATFORM" series [1]? Greg just
>> reported it did a trick for Versatile, there is a good chance it would work
>> for Integrator too ;)
> 
> My views on gluing multiplatform and nommu together have already been
> stated several times, and remain unchanged.
> 
> Greg's patch looks almost sane, but what I'd like to see is instead of
> directly doing this:
> 
>  config ARCH_VERSATILE
>         bool "ARM Ltd. Versatile family"
> -       depends on ARCH_MULTI_V5
> +       depends on ARCH_MULTI_V5 || ARM_SINGLE_ARMV5
> 
> we could do:
> 
>  config ARCH_VERSATILE
>         bool "ARM Ltd. Versatile family" if ARCH_MULTI_V5
> -       depends on ARCH_MULTI_V5
> +       depends on ARCH_MULTI_V5 || ARM_SINGLE_ARMV5
> 	default y if ARM_SINGLE_ARCH_VERSATILE
> 
> adding the versatile entry in the upper level choice (where it always used
> to be) but with "ARM_SINGLE_ARCH_VERSATILE" instead.
> 
> This would have the effect of allowing the multiplatform-converted stuff
> to start being used on nommu (again) but without running into the problems
> I've highlighted.

Thanks for the feedback Russell. Let me re-spin this patch with
this in mind.

Regards
Greg
