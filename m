From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Thu, 10 Jul 2014 12:13:37 -0400
Subject: [linux-sunxi] GSoC 2014 #0 status report - Improving Allwinner
 SoC support
In-Reply-To: <CAKON4Ozcz0A2Rbc=mEoZBvUgx0A-DMz1qKN8pf7U4UNNUd5K9A@mail.gmail.com>
References: <53BE0B4F.1090001@elopez.com.ar>
 <CAKON4OxPG7sYoJQSLu62ptzJPo9vBHxWBb+-+Z9nZ2EVBeJPww@mail.gmail.com>
 <CAKON4Ozcz0A2Rbc=mEoZBvUgx0A-DMz1qKN8pf7U4UNNUd5K9A@mail.gmail.com>
Message-ID: <CAKON4OyU1Qk4j_n4vNqjnKVTRuCxs3OFE6G0kjg+W6_+HUpq9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 8:38 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> On Thu, Jul 10, 2014 at 8:32 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
>> On Wed, Jul 9, 2014 at 11:41 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>>> Hi everyone,
>>>
>>> As some of you may know, I'm currently participating in Google Summer of
>>> Code under the Linux Foundation, working on a proposal titled "Improve
>>> Allwinner SoCs support on mainline Linux". There is a great quantity of
>>> devices out there that are powered by Allwinner processors, including but
>>> not limited to the various Cubieboards, OLinuXinos, STBs, Tablets and ?Mini
>>> PCs?. However, to date, support on mainline Linux is not yet feature
>>> complete. My proposal on particular focuses on DMA and analog audio on the
>>> earlier SoCs, and improved A23 support.
>>>
>>> The idea here is to make a weekly status report of the project. As we are
>>> starting mid-program, this one will be a bit different and I'll outline what
>>> has been worked on so far since the beginning.
>>>
>>> To date, I have been mainly working on the DMA driver for sun4i, sun5i and
>>> sun7i. Despite having completely different drivers on SDK kernels, the
>>> hardware block looks and behaves the same, so we are using a single driver
>>> for these three SoC families. I have sent a series of patches[1] as well as
>>> a follow-up v2[2], and I will keep iterating over it until it's accepted. I
>>> have also sent two trivial patches[3][4] as a side-effect.
>>>
>>> The main challenges while writing this driver can be summarized as a lack of
>>> documentation. First of all, it took me a bit to get to know DMAEngine. As
>>> there is not much documentation on it, most of my learning took place by
>>> reading pre-existing drivers and consulting with my mentor. Secondly, as the
>>> Allwinner documentation is mostly a register list with bitfield details, I
>>> also had to read the SDK drivers and do some trial and error testing to
>>> discover magic values and understand others.
>>>
>>> Lately, I have also been working on the audio part, now that I have a
>>> working DMA driver. After implementing cyclic DMA transfers and some clock
>>> code, and armed with a Buildroot image with mpg123 and an OpenBSD release
>>> track[5] in mp3 format, I've been trying to get some sound out of my
>>> Cubietruck's headphone jack, but without much success so far. I have
>>> verified my userspace stack and hardware by running these same binaries on
>>> top of the linux-sunxi 3.4 kernel, and it worked fine. I have since then
>>> been dumping relevant registers with devmem and comparing them, resolving
>>> issues as I see them - hopefully this will yield some audible results.
>>>

Residue is not calculated correctly...  it is bytes left, not bytes transmitted.

 * @residue: the remaining number of bytes left to transmit
 * on the selected transfer for states DMA_IN_PROGRESS and
 * DMA_PAUSED if this is implemented in the driver, else 0

list_for_each_entry(promise, &contract->demands, list) {
bytes += promise->len;
}

/*
* The hardware is configured to return the remaining byte
* quantity. If possible, replace the first listed element's
* full size with the actual remaining amount
*/
promise = list_first_entry_or_null(&contract->demands,
  struct sun4i_dma_promise, list);
if (promise && pchan) {
bytes -= promise->len;
if (pchan->is_dedicated)
bytes += readl(pchan->base + DDMA_BYTE_COUNT_REG);
else
bytes += readl(pchan->base + NDMA_BYTE_COUNT_REG);
}

exit:

dma_set_residue(state, bytes);


-- 
Jon Smirl
jonsmirl at gmail.com
