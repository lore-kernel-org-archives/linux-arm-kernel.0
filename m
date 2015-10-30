From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 30 Oct 2015 20:07:34 +0000
Subject: [PATCH] Documentation: dt: Add bindings for Secure-only devices
In-Reply-To: <CAL_JsqJz+w2SYEBLVGdZNS6J1tmt5VWV0q1G_Z2rgFfch6J=2A@mail.gmail.com>
References: <1446127303-5082-1-git-send-email-peter.maydell@linaro.org>
 <CAL_JsqJz+w2SYEBLVGdZNS6J1tmt5VWV0q1G_Z2rgFfch6J=2A@mail.gmail.com>
Message-ID: <CAFEAcA8qgFFhrmXePtO_xQx=YEHK8dSA-1SacR5NsQWSNTwj-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2015 at 18:28, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Oct 29, 2015 at 9:01 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> +Valid Secure world properties:
>> +
>> +- secure-status : specifies whether the device is present and usable
>> +  in the secure world. The combination of this with "status" allows
>> +  the various possible combinations of device visibility to be
>> +  specified:
>> +   status = "okay";                             // visible in S and NS
>
> I assume neither property present or both okay also mean the same.
>
> status = "okay"; secure-status = "okay";
>
> We should be explicit.

Yes; status defaults to "okay" (presumably this is listed in
the overal DT binding spec somewhere), and secure-status
defaults to "same as status, which might in turn be defaulted".
We can list the complete set of options (neither present,
both 'okay', status not present but secure-status present, etc),
though it gets a bit long-winded, especially if we later add
more secure- properties (they'd all have to have verbiage about
"if not present, same as non-prefixed property; if both not
present, both take the default the non-prefixed property takes
if it's not present; if prefixed property not present, it
defaults to same as non-prefixed property", which we already
say in the introductory section). Still, for just status it
would be easy enough to add a couple of lines:

+    status = "okay"; secure-status = "okay"; // ditto
+    secure-status = "okay";                  // ditto
+    // neither explicitly defined: ditto

(Do you want the full set of 9 options you get from multiplying
out "okay" vs "disabled" vs not-set for each property?)

>> +   status = "disabled"; secure-status = "okay"; // S-only
>> +   status = "okay"; secure-status = "disabled"; // NS-only
>
> In HKG when we discussed this, 'status = "secure"' was the proposal.
> That would be simpler:
>
> S world can use "okay" or "secure"
> NS world can use "okay" or no property.
>
> That leaves out the case of disabled in S and enabled for NS. We could
> want that for s/w reasons, but can we have h/w like that?

It's perfectly possible to design hardware like that (though
I can't think of a reason to do so offhand). I think it's the desire
to be able to describe all the possible valid h/w combinations
that brought us to this secure- prefix design. Plus it
extends nicely to cover other possibilities as we need it;
for instance "device A is at S-0x10000 but NS-0x20000" can be
done by specifying a device like:
   status = "okay";
   secure-status = "okay";
   reg = < 0x20000 0x1000 >;
   secure-regs = < 0x10000 0x1000 >;
(apologies if I've messed the syntax up there).

Just going for 'status=secure' would deal with the immediate
requirement, but my preference is for a description that
lets us describe all the possible configurations, not just
the ones we think are common, and secure-* is a neat way
of doing that (IIRC it was Grant's suggestion; speaking of
whom, I just noticed I forgot to cc him on the original patch).

thanks
-- PMM
