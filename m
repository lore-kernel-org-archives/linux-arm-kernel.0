From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Nov 2014 19:00:56 +0100
Subject: [PATCH v5 0/5] simplefb: add clock handling code
In-Reply-To: <5464CC5A.7010508@ti.com>
References: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
 <5464CC5A.7010508@ti.com>
Message-ID: <5464F1D8.5060106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/13/2014 04:20 PM, Tomi Valkeinen wrote:
> On 12/11/14 18:15, Hans de Goede wrote:
>> Hi Tomi,
>>
>> Here is v5 of my simplefb patch-set, this time with an Ack from
>> Grant Likely for the dt-bindings bits, which should end all controversy
>> surrounding that patch.
>>
>> For changes since the original postings please see the per patch changelogs
>> in the patch commit messages.
>>
>> Please merge this into your tree for 3.19.
> 
> I applied this and the "dt-bindings: simplefb: Specify node location and
> handoff related properties" v3 series to my test branch, compiled for
> x64 and:
> 
> drivers/video/fbdev/simplefb.c: In function ?simplefb_clocks_init?:
> drivers/video/fbdev/simplefb.c:204:2: error: implicit declaration of
> function ?of_clk_get_parent_count? [-Werror=implicit-function-declaration]
>   par->clk_count = of_clk_get_parent_count(np);
>   ^
> In file included from include/linux/i2c.h:33:0,
>                  from include/uapi/linux/fb.h:5,
>                  from include/linux/fb.h:5,
>                  from drivers/video/fbdev/simplefb.c:24:
> drivers/video/fbdev/simplefb.c: In function ?simplefb_init?:
> drivers/video/fbdev/simplefb.c:399:25: error: ?of_chosen? undeclared
> (first use in this function)
>   for_each_child_of_node(of_chosen, np) {
>                          ^
> include/linux/of.h:736:33: note: in definition of macro
> ?for_each_child_of_node?
>   for (child = of_get_next_child(parent, NULL); child != NULL; \
>                                  ^
> drivers/video/fbdev/simplefb.c:399:25: note: each undeclared identifier
> is reported only once for each function it appears in
>   for_each_child_of_node(of_chosen, np) {
>                          ^
> include/linux/of.h:736:33: note: in definition of macro
> ?for_each_child_of_node?
>   for (child = of_get_next_child(parent, NULL); child != NULL; \
>                                  ^
> 
> We need "depends on OF"?

Good catch!

So a quick-grep through the entire kernel sources has thought me that
apparently simplefb is used on non devicetree / of platforms through
platform-device instantiation, using the trick of naming the platform-device the
same as the driver to get the driver to bind.

So the answer to your compile breakage is to make the relevant code bits
be #ifdef CONFIG_OF

I'll respin the offending patch (5/5) in the "simplefb: add clock handling code"
series, and I'll respin the entire second series, as I need to also address
your comment on the example in the bindings there.

I hope to be able to post a re-spun version of both later tonight.

Regards,

Hans



> 
>  Tomi
> 
> 
