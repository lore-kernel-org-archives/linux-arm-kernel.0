From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Jul 2014 21:45:46 -0700
Subject: [GIT PULL 1/3] ARM: tegra: rework PCIe regulators
In-Reply-To: <20140707055211.GA15216@ulmo>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <20140707003854.GD8469@quad.lixom.net>
 <20140707055211.GA15216@ulmo>
Message-ID: <CAOesGMjwE=xThuUwmBF02YaQ32_uFogryW5anNoGc8yfkuN_Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 6, 2014 at 10:52 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Sun, Jul 06, 2014 at 05:38:54PM -0700, Olof Johansson wrote:
>> On Mon, Jun 23, 2014 at 03:23:44PM -0600, Stephen Warren wrote:
>> > This branch reworks the set of regulators that the Tegra PCIe driver
>> > uses, so that the driver and DT bindings more correctly model what's
>> > really going on in HW.
>> >
>> > I've made this a separate branch in case it needs to be pulled into the
>> > PCIe tree to resolve any conflicts. Any branch that adds Tegra124
>> > support to the PCIe driver will need to be based on this branch, and
>> > such patches might show up for 3.17, and be taken through the ARM tree
>> > so we can manage our own dependencies.
>>
>> Isn't PCI broken if you boot with an older device tree now?
>
> Yes.
>
>> I would like to see this as two branches: One to the PCI driver, and one
>> modifying DT contents. The PCI driver should remain working for old DTs,
>> so the last couple of commits on this branch can't be there.
>
> This is one of my main gripes with device tree these days. We have many
> situations where device tree bindings got rushed with the result that
> many of them describe hardware in a *completely* wrong way.
>
> The Tegra PCIe binding was designed with an incomplete understanding of
> the hardware (I wonder how many other cases there are like this in
> mainline) and it just happens to work by accident on existing platforms.
>
> So this really boils down to one question: how do we fix bugs in device
> tree bindings?
>
> I suppose we could keep some sort of backwards-compatible shim inside
> the driver to cope with the existing, wrong device tree binding. However
> that means an additional maintenance burden and I'm not convinced that
> there's a need in this particular case.

It's really unfortunate, and this is very likely not the last time
we're going to see something like this.

Backwards compatibility is only needed where there actually are users
of it. Are you absolutely 100% sure that there will not be such a
case? Trimslice users? Out-of-tree DTS:es that now need to be fixed up
or they will break? This isn't the same thing as in-kernel interface
changes where we say "out of tree, out of mind".

If you have to stay compatible, then I suggest you try to fill in
local driver variables with derivatives of the old properties (and
directly from the newer properties where you can). I haven't looked at
the specifics here so I don't know how hard it might be.

If you are 100% sure that you don't have to stay compatible, then you
can remove the code handling the old bindings. Still, even then I am a
little worried about dependencies (and more importantly conflicts)
between these dtsi changes and others done by tegra platform code for
this release. I suppose that can be resolved by having this as a base
of any DT changes for tegra if needed.


-Olof
