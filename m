From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 11:19:18 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
Message-ID: <51F7F596.6020503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 07:14 AM, jonsmirl at gmail.com wrote:
> On Tue, Jul 30, 2013 at 6:25 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jul 29, 2013 at 08:30:29PM -0400, jonsmirl at gmail.com wrote:
>>
>>> This...
>>> tx-dma-channel = <&pdma0 7>; /* preliminary */
>>> rx-dma-channel = <&pdma0 6>; /* preliminary */
>>
>>> Probably should be
>>> dmas = <&pdma0 7>,<&pdma0 6>;
>>> dma-names = "tx", "rx";
>>
>> It should be - the latter is the generic DMA binding.  There's a lot of
>> bindings in the kernel that predate that but people are currently
>> working to transfer over, this is one of the examples of instability
>> that everyone is talking about.
> 
> Is something similar to this possible in device tree syntax?
> dmas =  <"tx" &pdma0 7>,  <"rx"  &pdma0 6>;

I /think/ you can physically write that in *.dts, or something very
similar; with the strings outside the <>:

dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;

However, there's been strong push-back (i.e. doing that has not been
allowed at all) on attempting to mix variable-length strings and
fixed-length/alignment integer cells in the same property. This is
primarily because you then can't ensure that the integer cell data is
aligned in the DTB (dtc and/or the DTB format spec does/requires/allows
no alignment padding), and hence have to be much more careful about data
alignment when parsing the property.
