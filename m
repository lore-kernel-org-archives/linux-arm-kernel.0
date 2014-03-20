From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 20 Mar 2014 07:53:08 -0700
Subject: [PATCH v1 2/2] Documentation: devicetree: Add new binding for
 PSCIv0.2
In-Reply-To: <20140320142242.GC23372@e106331-lin.cambridge.arm.com>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
 <1395276865-6868-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140320030319.GO1297@cbox>
 <20140320142242.GC23372@e106331-lin.cambridge.arm.com>
Message-ID: <CAMJs5B8ak-UFFHvX_KsJowmoL_-9Xm0XYXSF-R48qb9Er-2w+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 March 2014 07:22, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 20, 2014 at 03:03:19AM +0000, Christoffer Dall wrote:
>> On Wed, Mar 19, 2014 at 08:54:25PM -0400, Ashwin Chaugule wrote:
>> > The PSCI v0.2+ spec defines static values for PSCI function IDs.
>> > Add a new binding entry so that pre v0.2 implementations can
>> > use DT entries for function IDs and v0.2+ implementations use
>> > static entries as defined by the PSCIv0.2 specification.
>> >
>> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > ---
>> >  Documentation/devicetree/bindings/arm/psci.txt | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
>> > index 433afe9..a808284 100644
>> > --- a/Documentation/devicetree/bindings/arm/psci.txt
>> > +++ b/Documentation/devicetree/bindings/arm/psci.txt
>> > @@ -21,7 +21,11 @@ to #0.
>> >
>> >  Main node required properties:
>> >
>> > - - compatible    : Must be "arm,psci"
>> > + - compatible    : "arm,psci" : pre PSCIv0.2 spec implementations use this
>> > +                   to get the function IDs from DT entries.
>> > +
>> > +                   "arm,psci-0.2": PSCIv0.2+ spec implementations use static
>> > +                   values for function IDs as defined in the spec.
>
> How about:
>
> - compatible: should contain at least one of:
>
>   * "arm,psci" : for implementations complying to PSCI versions prior to
>     0.2. For these cases function IDs must be provided.
>
>   * "arm,psci-0.2" : for implementations complying to PSCI 0.2. Function
>     IDs are not required and should be ignored by an OS with PSCI 0.2
>     support, but are permitted to be present for compatibility with
>     existing software when "arm,psci" is later in the compatible list.
>
>> Maybe specify that in this case no function IDs are passed in the device
>> tree?
>
> As described above, for compatibility with existing kernels, the
> hypervisor will likely want to provide IDs, e.g.
>
> psci {
>         compatible = "arm,psci-0.2", "arm,psci";
>         method = "hvc";
>
>         cpu_on = < arbitrary value >;
>         cpu_off = < arbitrary value >;
>
>         ...
> };
>
> In this case I'd expect an OS with PSCI 0.2 support to use the PSCI 0.2
> IDs, but an older OS would use the IDs from the DT (which may or may not
> match the PSCI 0.2 IDs).
>
> So while we should say is any function IDs should be ignored for
> "arm,psci-0.2", we shouldn't say that they are disallowed in the node.
>
> The document should have examples of "arm,psci" only, "arm,psci-0.2"
> only, and the compatibility case.
>
That solves the ambiguity I read with the first draft, thanks.

-Chritoffer
