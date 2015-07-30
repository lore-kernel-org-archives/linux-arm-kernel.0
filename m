From: slash.tmp@free.fr (Mason)
Date: Thu, 30 Jul 2015 16:54:57 +0200
Subject: arch/arm/kernel/setup.c does not compile at -O0
In-Reply-To: <55BA2D9D.1070402@free.fr>
References: <55BA1E62.9080103@free.fr> <55BA2335.706@arm.com>
 <55BA2D9D.1070402@free.fr>
Message-ID: <55BA3AC1.905@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/2015 15:58, Mason wrote:

> On 30/07/2015 15:14, Robin Murphy wrote:
> 
>> On 30/07/15 13:53, Mason wrote:
>>
>>> Any idea how I can get DS-5 to properly handle local variables?
>>
>> I carry a patch locally reverting 2062afb4f804 - at least on arm64, the 
>> debugger manages to resolve optimised locals considerably better without 
>> the -fno-var-tracking-assignments option. The Kconfig "Generate dwarf4 
>> debug info" option is a good idea, and "Generate readable assembly code" 
>> sometimes helps a bit too.
> 
> I reverted 2062afb4f804 (I'm using 4.9.3 so I think it's safe)
> 
> AFAICT, config DEBUG_INFO_DWARF4 isn't available in 3.14
> (I think bfaf2dd3509b was included in 3.16)
> 
> But the problem seems to be on a higher level. My debugger
> just doesn't see ANY local variable whatsoever.
> 
> For example, if I break in serial8250_probe, step past the
> initializations, then the Eclipse "Variables" tab states
> Locals: 0 variables (as it does everywhere, mind you).
> 
> If I try to print from the "Commands" tab:
> 
> print p
> ERROR(EXP8): Could not find the symbol "p"
> print irqflag
> ERROR(EXP8): Could not find the symbol "irqflag"
> 
> I'm doing wrong something fundamental.
> 
> This is my work flow:
> 
> Start the system, interrupt it in Uboot
> Connect the DS-5 probe
> Set a HW breakpoint at the address of start_kernel
> Let Uboot load the kernel
> When the breakpoint is hit, load the symbols with:
>   add-symbol-file /opt/linux-3.14/vmlinux
> 
> => Is vmlinux supposed to contain the debug info for the
> local variables? (I mean 'automatic' variables, in the
> C sense.)

I went all-in, and set

KBUILD_CFLAGS	+= -g3

in the top-level Makefile.

Still no local variables shown.


http://eli.thegreenplace.net/2011/02/07/how-debuggers-work-part-3-debugging-information/

$ arm-linux-gnueabihf-objdump -x vmlinux | grep "\.debug"
 25 .debug_line    0041075d  00000000  00000000  003679d3  2**0
 26 .debug_info    01a54a2f  00000000  00000000  00778130  2**0
 27 .debug_abbrev  000edef8  00000000  00000000  021ccb5f  2**0
 28 .debug_aranges 00007508  00000000  00000000  022baa58  2**3
 29 .debug_ranges  000ab8c8  00000000  00000000  022c1f60  2**3
 30 .debug_frame   000a5864  00000000  00000000  0236d828  2**2
 31 .debug_str     001aa5cd  00000000  00000000  0241308c  2**0
 32 .debug_macro   0041d5d4  00000000  00000000  025bd659  2**0
 33 .debug_loc     00427524  00000000  00000000  029dac2d  2**0

$ arm-linux-gnueabihf-objdump --dwarf=info vmlinux | wc
12972723 60571026 650075352

Seems there is a lot of information available, but the debugger
doesn't seem to be able to make use of it...

To take my serial8250_probe example:

static int serial8250_probe(struct platform_device *dev)
{
	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
	struct uart_8250_port uart;
	int ret, i, irqflag = 0;

 <1><101ea81>: Abbrev Number: 76 (DW_TAG_subprogram)
    <101ea82>   DW_AT_name        : (indirect string, offset: 0x152f7a): serial8250_probe       
    <101ea86>   DW_AT_decl_file   : 1   
    <101ea87>   DW_AT_decl_line   : 3089        
    <101ea89>   DW_AT_prototyped  : 1   
    <101ea89>   DW_AT_type        : <0x100ec7a> 
    <101ea8d>   DW_AT_low_pc      : 0xc018e0f4  
    <101ea91>   DW_AT_high_pc     : 0x228       
    <101ea95>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
    <101ea97>   DW_AT_GNU_all_tail_call_sites: 1        
    <101ea97>   DW_AT_sibling     : <0x101eb39> 
 <2><101ea9b>: Abbrev Number: 77 (DW_TAG_formal_parameter)
    <101ea9c>   DW_AT_name        : dev 
    <101eaa0>   DW_AT_decl_file   : 1   
    <101eaa1>   DW_AT_decl_line   : 3089        
    <101eaa3>   DW_AT_type        : <0x10127be> 
    <101eaa7>   DW_AT_location    : 3 byte block: 91 e4 7d      (DW_OP_fbreg: -284)
 <2><101eaab>: Abbrev Number: 88 (DW_TAG_variable)
    <101eaac>   DW_AT_name        : p   
    <101eaae>   DW_AT_decl_file   : 1   
    <101eaaf>   DW_AT_decl_line   : 3091        
    <101eab1>   DW_AT_type        : <0x101eb39> 
    <101eab5>   DW_AT_location    : 2 byte block: 91 6c         (DW_OP_fbreg: -20)
 <2><101eab8>: Abbrev Number: 89 (DW_TAG_variable)
    <101eab9>   DW_AT_name        : (indirect string, offset: 0x150dd5): uart   
    <101eabd>   DW_AT_decl_file   : 1   
    <101eabe>   DW_AT_decl_line   : 3092        
    <101eac0>   DW_AT_type        : <0x101846a> 
    <101eac4>   DW_AT_location    : 3 byte block: 91 e8 7d      (DW_OP_fbreg: -280)
 <2><101eac8>: Abbrev Number: 88 (DW_TAG_variable)
    <101eac9>   DW_AT_name        : ret 
    <101eacd>   DW_AT_decl_file   : 1   
    <101eace>   DW_AT_decl_line   : 3093        
    <101ead0>   DW_AT_type        : <0x100ec7a> 
    <101ead4>   DW_AT_location    : 2 byte block: 91 58         (DW_OP_fbreg: -40)
 <2><101ead7>: Abbrev Number: 88 (DW_TAG_variable)
    <101ead8>   DW_AT_name        : i   
    <101eada>   DW_AT_decl_file   : 1   
    <101eadb>   DW_AT_decl_line   : 3093        
    <101eadd>   DW_AT_type        : <0x100ec7a> 
    <101eae1>   DW_AT_location    : 2 byte block: 91 68         (DW_OP_fbreg: -24)
 <2><101eae4>: Abbrev Number: 89 (DW_TAG_variable)
    <101eae5>   DW_AT_name        : (indirect string, offset: 0x151780): irqflag        
    <101eae9>   DW_AT_decl_file   : 1   
    <101eaea>   DW_AT_decl_line   : 3093        
    <101eaec>   DW_AT_type        : <0x100ec7a> 
    <101eaf0>   DW_AT_location    : 2 byte block: 91 64         (DW_OP_fbreg: -28)


I'm running out of ideas. I'll give DWARF 4 a try.

My debugger is ARM DS-5 v5.13 (Build 1622)

Regards.
