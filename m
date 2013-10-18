From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 18 Oct 2013 15:36:38 +0300
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <1382094190.3394.13.camel@linaro1.home>
References: <20131017125533.GD2442@localhost.localdomain>
 <1382094190.3394.13.camel@linaro1.home>
Message-ID: <52612B56.6070302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2013 02:03 PM, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-10-17 at 13:55 +0100, Dave Martin wrote:
>> On Thu, Oct 17, 2013 at 01:17:23PM +0100, Jon Medhurst (Tixy) wrote:
>>> I'll send a patch proposing that fix after I've worked out how to test
>>> it on a big-endian kernel. Or if someone else sends a patch for that
>>> with a good commit message that explains what's going on I'll happily
>>> ack that.
>>
>> Disassemble-testing may be enough -- but I advise to dump the relevant
>> code section with objdump -s as well as reading the code disassembly.
>> The hex dump does not lie, whereas the disassembler does sometimes get
>> confused in cases like this.
>>
>> Building and disassembling in BE8 and LE configurations will exercise
>> the two main cases (linker swabbing versus no swabbing) -- comparing
>> the dump of vmlinux with the dump of the .o file shows what the linker
>> is doing.
> 
> Thanks, that's the clue I was missing. I was looking at objdumps of .o
> files and wasn't seeing any byte changes caused by this bug, just the
> disassembler treating data as code. Doing a dump of the final linked
> vmlinux I now see that exactly because the data is being treated as
> code, the linking is swapping the byte order of the data, (because ARM
> instructions are always little-endian and need to be fixed from their
> big-endian representation in the .o file?).
> 
> In another branch of this thread, Taras said he had patches that were
> tested, so I'll wait for those rather than doing one myself. Taras
> should get the main credit for this investigation anyway :-)
> 

I've just sent patches to Ben.

I was looking into gas code and found an opposite bug:
If NOP-padding is used to align data it can be treated as data
and saved in BE format.
So we definitely have to explicitly specify fill value for data
alignment in code section.

-- 
Taras Kondratiuk
