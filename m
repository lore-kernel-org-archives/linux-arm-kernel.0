From: aric@sdgsystems.com (Aric D. Blumer)
Date: Fri, 26 Feb 2010 08:12:09 -0500
Subject: Soft Lockup Debugging
In-Reply-To: <20100225214318.GB24043@n2100.arm.linux.org.uk>
References: <4B869531.3030708@sdgsystems.com>
	<20100225214318.GB24043@n2100.arm.linux.org.uk>
Message-ID: <4B87C8A9.6030606@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2010 04:43 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 25, 2010 at 10:20:17AM -0500, Aric D. Blumer wrote:
>   
>> [  450.102093] Exception stack(0xcfd79b70 to 0xcfd79bb8)
>> [  450.107170] 9b60:                                     00000029 cf80aac0 c043b7f4 40000013 
>> [  450.115604] 9b80: cf80aac0 00000029 00000029 c040d730 cfd78000 c0440900 0000000a cfd79bd4 
>> [  450.124064] 9ba0: cfd79bd8 cfd79bb8 c007cc8c c007b1ac 40000013 ffffffff                   
>> [  450.132506]  r6:04000000 r5:cfd79ba4 r4:ffffffff
>> [  450.137222] [<c007b180>] (handle_IRQ_event+0x0/0x84) from [<c007cc8c>] (handle_level_irq+0x78/0xf0)
>> [  450.146419]  r7:c040d730 r6:cfd79cb0 r5:00000029 r4:c0416648
>> [  450.152195] [<c007cc14>] (handle_level_irq+0x0/0xf0) from [<c0030060>] (__exception_text_start+0x60/0x74)
>> [  450.161910]  r5:c0447f20 r4:00000029
>> [  450.165559] [<c0030000>] (__exception_text_start+0x0/0x74) from [<c0030a70>] (__irq_svc+0x30/0xc0)
>> [  450.174667] Exception stack(0xcfd79c10 to 0xcfd79c58)
>> [  450.179745] 9c00:                                     00000014 cf8bce00 c043b7a0 40000013 
>> [  450.188188] 9c20: cf8bce00 00000014 00000014 c040d730 cfd78000 c0440900 0000000a cfd79c74 
>> [  450.196649] 9c40: cfd79c78 cfd79c58 c007cc8c c007b1ac 40000013 ffffffff                   
>> [  450.205105]  r6:00000200 r5:cfd79c44 r4:ffffffff
>> [  450.209815] [<c007b180>] (handle_IRQ_event+0x0/0x84) from [<c007cc8c>] (handle_level_irq+0x78/0xf0)
>> [  450.219011]  r7:c040d730 r6:cfd79d60 r5:00000014 r4:c041615c
>> [  450.224797] [<c007cc14>] (handle_level_irq+0x0/0xf0) from [<c0030060>] (__exception_text_start+0x60/0x74)
>> [  450.234512]  r5:c0447f20 r4:00000014
>> [  450.238159] [<c0030000>] (__exception_text_start+0x0/0x74) from [<c0030a70>] (__irq_svc+0x30/0xc0)
>>     
> Looks to me like a stuck IRQ problem - but no idea which IRQ.  You'll
> need to disassemble handle_IRQ_event to find out which register the
> interrupt number ends up in when PC=0xc007b1ac, and then read it
> from the exception stack.  The register order there is:
>
> 	r0-r12, sp (r13), lr (r14), pc (r15), cpsr, -1
>   

I see.  So when interpreting soft lockup backtraces, the most important
context is probably the one that the soft lockup detection code
interrupts, and in this case it is the IRQ handlers.  Makes perfect
sense in hindsight.

You were right.  The issue is a stuck IRQ in the pxamci.c code.  I've
got a fix, but it's relevant to this discussion:

http://lists.arm.linux.org.uk/lurker/message/20090615.210855.a3f32cf1.en.html

Thanks for the help!
