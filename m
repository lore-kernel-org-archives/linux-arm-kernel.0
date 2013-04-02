From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 09:36:14 -0600
Subject: How to represent negative values for device tree property
In-Reply-To: <20130402062925.GJ7426@truffula.fritz.box>
References: <5159F760.1080605@codeaurora.org> <515A038F.2090902@wwwdotorg.org>
 <515A2533.8050005@codeaurora.org> <20130402062925.GJ7426@truffula.fritz.box>
Message-ID: <515AFAEE.4050300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 12:29 AM, David Gibson wrote:
> On Mon, Apr 01, 2013 at 05:24:19PM -0700, David Collins wrote:
>> On 04/01/2013 03:00 PM, Stephen Warren wrote:
>>> On 04/01/2013 03:08 PM, David Collins wrote:
>>>> Hi,
>>>> 
>>>> I am working on a thermal driver which needs to be able to
>>>> read a temperature threshold from a device tree property.
>>>> The hardware supports thresholds in the range -204.8 to
>>>> +204.7 C in 0.1 C steps.  I have found, as I am sure others
>>>> have as well, that dtc treats a '-' before an integer in a
>>>> dtsi file as a syntax error.  Therefore, I need some
>>>> artificial way to represent negative numbers in device tree.
>>>> Here are the possibilities that I have thought of so far:
>>> 
>>> Doesn't the very latest dtc, which contains integer expression
>>> support, allow unary -? I thought that code had been imported
>>> into the kernel (goes and checks) yes it has. What's the error
>>> you're seeing; over/underflow or syntax?
>>> 
>>> That said, DT cells are supposed to be u32 not s32, so perhaps
>>> this isn't unexpected.
> 
> That's.. sort of true, but misleading.  As far as the dtb format
> is concerned, properties are just a bag of bytes.  Individual
> device bindings define how software should interpret those bytes.
> 
> The dtc data "types" are really just convenient ways to enter
> various sorts of commonly used bytestrings.  Some of the dtc code
> treats cells as u32 because that works for its purposes (and in
> particular avoids some nasty C standard gotchas where signed
> overflows may have undefined results), but there's no reason you
> can't treat it as an s32.  On dtc versions recent enough to have
> arithmetic, unary minus and subtractive overflow will use 2's
> complement, as you'd expect.

OK, perhaps I was extrapolating too far from the fact that all the
DT-related code in the kernel (just happens to) only read integers as
u32. It sounds like it'd be fine to add e.g. of_property_read_s32()
alongside the existing of_property_read_u32() then. I imagine that
would be quite useful.
