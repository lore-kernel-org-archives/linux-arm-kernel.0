From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 08 May 2013 09:21:40 +0200
Subject: [PATCH 1/3] clk: mvebu: add gate ctrl for Prestera kirkwood
 variants
In-Reply-To: <5189F900.6020809@keymile.com>
References: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
 <1367941941-19152-2-git-send-email-valentin.longchamp@keymile.com>
 <518927C0.6070600@free-electrons.com> <51892D8D.4060704@gmail.com>
 <5189F900.6020809@keymile.com>
Message-ID: <5189FD04.8090308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2013 09:04 AM, Valentin Longchamp wrote:
> On 05/07/2013 06:36 PM, Sebastian Hesselbarth wrote:
>> I just checked my mails from late 2012 and there Valentin and I agreed,
>> that not the missing bits in clock gating control registers was the root
>> cause of km_kirkwood to hang. It was rather the phy gates (that do not/
>> not yet exist on DT) that caused it to hang, i.e. when accessing SATA
>> PHY registers.
>
> Yeah you are right, I had forgotten about this test. I just had a look at the
> board-km_kirkwood.c and I tried to figure out a way to make sure the clock gates
> bits never get read/written, so never get initialized. But as you say, that's
> not the real cause of the hang but
>
>> Valentin, I am not against an extra clock-gating-ctrl for Prestera but
>> maybe having an kirkwood.dtsi fork without SATA and other peripherals
>> will also help?
>
> Since it's not the real problem having the extra clock-gating-ctrl would me more
> consistent with the real Prestera HW, but maybe it's better to keep only one
> that works for both as it's already the case, it's less code to maintain.
>
> A better approach would be to work on the kirkwood.dtsi as you mention it. The
> SATA node in kirkwood.dtsi is by default disabled, is this enough or should it
> be moved to kirkwood-6281.dtsi for instance ?

Valentin,

I guess for the long run, we will re-introduce phy gates either by
abusing clk gates or some other way. But they will depend on existing
OF nodes.

Considering this, it would be best to fork kirkwood.dtsi for Prestera
and leave out all OF nodes that are not implemented there. We could
have

kirkwood.dtsi -+-> kirkwood-kirkwood.dtsi -+-> kirkwood-6281.dtsi
                +-> kirkwood-prestera.dtsi  +-> kirkwood-6282.dtsi

or any other naming scheme. Maybe Andrew or Jason can comment on this.

>> And: Does DT-enabled km_kirkwood ever hang without the hack in it's
>> board setup? There should be no PHY gates on DT boards..
>
> I have just tested it and it does not hang, so I will submit and patch that
> simply removes this workaround since the PHY gates are not accessed anymore
> (thanks to DT clock gates and that km_kirkwood does not enable the sata of node).

Great! I suggest to also submit the dtsi changes above within the same
patch set.

Sebastian
