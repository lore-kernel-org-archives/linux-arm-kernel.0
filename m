From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 15:37:52 -0600
Subject: [RFC 04/10] memory: Add Tegra124 memory controller support
In-Reply-To: <20140627111514.GE2797@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
 <9283417.yKmnrljUYI@wuerfel> <20140627111514.GE2797@ulmo>
Message-ID: <53ADE430.6020209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 05:15 AM, Thierry Reding wrote:
> On Fri, Jun 27, 2014 at 01:07:04PM +0200, Arnd Bergmann wrote:
>> On Thursday 26 June 2014 22:49:44 Thierry Reding wrote:
>>> +static const struct tegra_mc_client tegra124_mc_clients[] = {
>>> +       {
>>> +               .id = 0x01,
>>> +               .name = "display0a",
>>> +               .swgroup = TEGRA_SWGROUP_DC,
>>> +               .smmu = {
>>> +                       .reg = 0x228,
>>> +                       .bit = 1,
>>> +               },
>>> +               .latency = {
>>> +                       .reg = 0x2e8,
>>> +                       .shift = 0,
>>> +                       .mask = 0xff,
>>> +                       .def = 0xc2,
>>> +               },
>>> +       }, {
>>
>> This is a rather long table that I assume would need to get duplicated
>> and modified for each specific SoC. Have you considered to put the information
>> into DT instead, as auxiliary data in the iommu specifier as provided by
>> the device?
> 
> Most of this data really is register information and I don't think that
> belongs in DT.

I agree. I think it's quite inappropriate to put information into DT
that could simply be put into a table in the driver. If the information
is put into DT, you have to define a fixed binding for it, munge the
table and data representation to fit DT's much less flexible (than C
structs/arrays) syntax, write a whole bunch of code to parse it back out
(at probably not do a good job with error-checking), all only to end up
with exactly the same C structs in the driver at the end of the process.
Oh, and if multiple SoCs use the same data values, you have to duplicate
those tables into at least the DTBs if not in the .dts files, whereas
with C you can just point at the same struct.

SoCs come out much less frequently than new boards (perhaps ignoring the
fact that we support a small subset of boards in mainline, so the
frequency isn't too dissimilar there). It makes good sense to put
board-to-board differences in DT, but I see little point in putting
static SoC information into DT.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/95dbab9d/attachment-0001.sig>
