From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 28 Feb 2017 10:16:45 -0800
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <20170228112144.65455de5@gandalf.local.home>
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
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
Message-ID: <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 08:21 AM, Steven Rostedt wrote:
> On Tue, 28 Feb 2017 10:25:46 +0530
> Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>
>> File: ./net/ipv4/xfrm4_input.o
>>   [12] __jump_table      PROGBITS        0000000000000000 000639 000018 18 WAM  0   0  1
>> File: ./net/ipv4/udplite.o
>> File: ./net/ipv4/xfrm4_output.o
>>   [ 9] __jump_table      PROGBITS        0000000000000000 000481 000018 18 WAM  0   0  1
>
> Looks like there's some issues right there.

Those look good to me 18/18 = 1 with no remainder.  The odd numbers are 
the offset of the section in the ELF file.

If you look at the stack trace, it seems that it is during module loading.

Are the primitives for generating the tables doing something different 
for the module case?  I am not familiar enough with the powerpc ABIs to 
know.

Try this:

$ perl -n -e 's/\[ /\[/; my @f = split " "; print hex($f[5]) % 0x18 if 
$#f > 5; print $_' <~/jump_table.log


There are no entries with size that is not a multiple of 0x18.

I think my patch to add the ENTSIZE is not doing anything here.

I suspect that the alignment of the __jump_table section in the .ko 
files is not correct, and you are seeing some sort of problem due to that.




>
> -- Steve
>
