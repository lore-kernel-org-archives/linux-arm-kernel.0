From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 27 Feb 2017 15:34:44 -0800
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Message-ID: <8fb467e8-2ab9-e52b-ea47-083947b9cfe4@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2017 02:50 PM, Jason Baron wrote:
>
>
> On 02/27/2017 05:45 PM, David Daney wrote:
>> On 02/27/2017 02:36 PM, Steven Rostedt wrote:
>>> On Mon, 27 Feb 2017 14:21:21 -0800
>>> David Daney <ddaney@caviumnetworks.com> wrote:
>>>
>>>> See attached for mips.  It seems to do the right thing.
>>>>
>>>> I leave it as an exercise to the reader to fix the other architectures.
>>>>
>>>> Consult your own  binutils experts to verify that what I say is true.
>>>
>>> It may still just be safer to do the pointers instead. That way we
>>> don't need to worry about some strange arch or off by one binutils
>>> messing it up.
>>
>> Obviously it is your choice, but this is bog standard ELF linking.  In
>> theory even the arrays of power-of-2 sized objects should also supply an
>> entity size.  Think __ex_table and its ilk.
>>
>>
>> The benefit of supplying an entsize is that you don't have to change the
>> structure of the existing code and risk breaking something in the
>> process.
>>
>> David Daney
>>
>>
>
> Thanks for the suggestion! I would like to see if this resolves the ppc
> issue we had. I'm attaching a powerpc patch based on your suggestion.
> Hopefully, Sachin can try it.
>

If there are problems, you could try something like:


$ find . -name \*\.o | xargs mips64-octeon-linux-gnu-readelf -eW  | grep 
'File:\| __jump_table'
File: ./drivers/firmware/built-in.o
File: ./drivers/built-in.o
   [3249] __jump_table      PROGBITS        0000000000000000 1838c8 
0022c8 18 WAM  0   0  8
File: ./drivers/spi/built-in.o
   [82] __jump_table      PROGBITS        0000000000000000 008cb0 000048 
18 WAM  0   0  8
File: ./drivers/spi/spi-cavium-octeon.o
File: ./drivers/spi/spi-cavium.o
File: ./drivers/spi/spi.o
.
.
.

Look for files where the size of the __jump_table section is not a 
integer multiple of the entsize.



> Thanks,
>
> -Jason
