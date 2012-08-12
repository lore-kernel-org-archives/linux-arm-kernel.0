From: cyril@ti.com (Cyril Chemparathy)
Date: Sun, 12 Aug 2012 12:32:47 -0400
Subject: [PATCH v2 02/22] ARM: add self test for runtime patch mechanism
In-Reply-To: <alpine.LFD.2.02.1208112226310.5231@xanadu.home>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
 <1344648306-15619-3-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208112226310.5231@xanadu.home>
Message-ID: <5027DAAF.2060406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/12 22:35, Nicolas Pitre wrote:
> On Fri, 10 Aug 2012, Cyril Chemparathy wrote:
>
>> This patch adds basic sanity tests to ensure that the instruction patching
>> results in valid instruction encodings.  This is done by verifying the output
>> of the patch process against a vector of assembler generated instructions at
>> init time.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> ---
[...]
>> +	__asm__ __volatile__ (
>> +		"	.irp	shift1, 0, 6, 12, 18\n"
>> +		"	.irp	shift2, 0, 1, 2, 3, 4, 5\n"
>> +		"	add     r1, r2, #(0x41 << (\\shift1 + \\shift2))\n"
>> +		"	.endr\n"
>> +		"	.endr\n"
>
>
> Maybe adding a "add r1, r2 #0x81 << 24" here might be a good thing since
> this is the most used case but missing from the above.
>

Indeed.  I've now replaced this with something a bit more extensive. 
Does the following look better?

+struct patch_test_imm8 {
+       u16     imm;
+       u16     shift;
+       u32     insn;
+};
+
+static void __init __used __naked __patch_test_code_imm8(void)
+{
+       __asm__ __volatile__ (
+
+               /* a single test case */
+               "       .macro          test_one, imm, sft\n"
+               "       .hword          \\imm\n"
+               "       .hword          \\sft\n"
+               "       add             r1, r2, #(\\imm << \\sft)\n"
+               "       .endm\n"
+
+               /* a sequence of tests@'inc' increments of shift */
+               "       .macro          test_seq, imm, sft, max, inc\n"
+               "       test_one        \\imm, \\sft\n"
+               "       .if             \\sft < \\max\n"
+               "       test_seq        \\imm, (\\sft + \\inc), \\max, 
\\inc\n"
+               "       .endif\n"
+               "       .endm\n"
+
+               /* an empty record to mark the end */
+               "       .macro          test_end\n"
+               "       .hword          0, 0\n"
+               "       .word           0\n"
+               "       .endm\n"
+
+               /* finally generate the test sequences */
+               "       test_seq        0x41, 0, 24, 1\n"
+               "       test_seq        0x81, 0, 24, 2\n"
+               "       test_end\n"
+               : : :
+       );
+}
+

[...]
>> +	u32 test_code_addr = (u32)(&__patch_test_code_imm8);
>> +	u32 *test_code = (u32 *)(test_code_addr & ~0x3);
>
> Why this masking?  With Thumb2 you may find functions starting at
> halfword aligned addresses.  Only the LSB (indicating thumb mode) should
> be masked out.
>

Fixed.  Thanks.

Thanks
-- Cyril.
