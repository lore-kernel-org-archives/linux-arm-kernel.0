From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 27 Feb 2017 14:21:21 -0800
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <20170227170911.2280ca3e@gandalf.local.home>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
Message-ID: <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2017 02:09 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 13:41:13 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> On 02/27/2017 01:06 PM, Steven Rostedt wrote:
>>> On Mon, 27 Feb 2017 11:59:50 -0800
>>> David Daney <ddaney@caviumnetworks.com> wrote:
>>>
>>>> For me the size is not the important issue, it is the alignment of the
>>>> struct jump_entry entries in the table.  I don't understand how your
>>>> patch helps, and I cannot Acked-by unless I understand what is being
>>>> done and can see that it is both correct and necessary.
>>>
>>> You brought up a very good point and I'm glad that I had Jason Cc all
>>> the arch maintainers in one patch.
>>>
>>> I think jump_labels may be much more broken than we think, and Jason's
>>> fix doesn't fix anything. We had this same issues with tracepoints.
>>>
>>> I'm looking at jump_label_init, and how we iterate over an array of
>>> struct jump_entry's that was put together by the linker. The problem is
>>> that jump_entry is not a power of 2 in size.
>>>
>>
>> ELF sections may have an ENTSIZE property exactly for arrays.  Since
>> each jump_entry will have a unique value they cannot be merged, but we
>> can tell the assembler they are an array and get them properly packed.
>> Perhaps something like (untested):
>>
>>     .pushsection __jump_table,  \"awM\", at progbits,24
>>     FOO
>>     .popsection
>>
>
> And the linker will honor this too?

See attached for mips.  It seems to do the right thing.

I leave it as an exercise to the reader to fix the other architectures.

Consult your own  binutils experts to verify that what I say is true.


David Daney
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-MIPS-jump_lable-Give-__jump_table-elements-an-entsiz.patch
Type: text/x-patch
Size: 2317 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/b2d33eff/attachment-0001.bin>
