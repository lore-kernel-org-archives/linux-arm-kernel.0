From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 18:16:51 +0000
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <20130130180331.GP23505@n2100.arm.linux.org.uk>
References: <51093B0B.7010708@arm.com>
 <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
 <20130130162132.GM23505@n2100.arm.linux.org.uk>
 <20130130164535.GN23505@n2100.arm.linux.org.uk>
 <20130130171918.GO23505@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
 <20130130180331.GP23505@n2100.arm.linux.org.uk>
Message-ID: <20130130181651.GQ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 06:03:31PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 30, 2013 at 12:30:06PM -0500, Nicolas Pitre wrote:
> > That should probably be:
> > 
> > 	u32 mask;
> > 
> > 	for (i = 0; i < 32; i += 4) {
> > 		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> > 		mask |= (mask >> 16);
> > 		mask |= (mask >> 8);
> > 		if (mask)
> > 			return mask;
> > 	}
> > 
> > I know that the spec says that the GIC should accept byte sized 
> > accesses, but that too is known not to work on all implementations.
> 
> Well, it really doesn't make that much difference... because from what
> I can see the kernel is rather sodded up as it currently stands.
> 
> There was a time when the kernel ran on the ARM Realview EB.  But it
> doesn't today...
> 
> Why is it when I walk away from anything kernel related and then come
> back to it, it's always sodded up and rather terminally broken?

Finally, it now tries to mount a rootfs, and dies with the following:

BUG: spinlock lockup suspected on CPU#0, init/1                               
 lock: 0xcf8bde10, .magic: dead4ead, .owner: init/1, .owner_cpu: 0            
Backtrace:                                                                      
[<c00185d8>] (dump_backtrace+0x0/0x10c) from [<c03294e8>] (dump_stack+0x18/0x1c)
 r6:cf8bde10 r5:cf83d1c0 r4:cf8bde10 r3:cf83d1c0                                
[<c03294d0>] (dump_stack+0x0/0x1c) from [<c018926c>] (spin_dump+0x84/0x98)      
[<c01891e8>] (spin_dump+0x0/0x98) from [<c0189460>] (do_raw_spin_lock+0x100/0x19
8)                                                                              
 r5:00000000 r4:025e4000                                                        
[<c0189360>] (do_raw_spin_lock+0x0/0x198) from [<c032cbac>] (_raw_spin_lock+0x3c
/0x44)                                                                          
[<c032cb70>] (_raw_spin_lock+0x0/0x44) from [<c01c9224>] (pl011_console_write+0x
e8/0x11c)                                                                       
 r5:c0481780 r4:cf8bde10                                                        
[<c01c913c>] (pl011_console_write+0x0/0x11c) from [<c002aea8>] (call_console_dri
vers.clone.7+0xdc/0x104)                                                        
[<c002adcc>] (call_console_drivers.clone.7+0x0/0x104) from [<c002b320>] (console
_unlock+0x2e8/0x454)                                                            
[<c002b038>] (console_unlock+0x0/0x454) from [<c002b8b4>] (vprintk_emit+0x2d8/0x
594)                                                                            
[<c002b5dc>] (vprintk_emit+0x0/0x594) from [<c0329718>] (printk+0x3c/0x44)      
[<c03296dc>] (printk+0x0/0x44) from [<c002929c>] (warn_slowpath_common+0x28/0x6c
)                                                                               
 r3:00000009 r2:c0070ab0 r1:00000ab3 r0:c0334b60                                
[<c0029274>] (warn_slowpath_common+0x0/0x6c) from [<c0029304>] (warn_slowpath_nu
ll+0x24/0x2c)                                                                   
 r8:c00beb00 r7:000000d0 r6:cf8001c0 r5:60000093 r4:cf83e000                    
r3:00000009                                                                     
[<c00292e0>] (warn_slowpath_null+0x0/0x2c) from [<c0070ab0>] (lockdep_trace_allo
c+0xd8/0xf0)                                                                    
[<c00709d8>] (lockdep_trace_alloc+0x0/0xf0) from [<c00c0850>] (kmem_cache_alloc+
0x24/0x11c)                                                                     
 r5:20000008 r4:000080d0                                                        
[<c00c082c>] (kmem_cache_alloc+0x0/0x11c) from [<c00bb044>] (__get_vm_area_node.
clone.24+0x7c/0x16c)                                                            
 r7:000000d0 r6:00000001 r5:20000008 r4:cf83fbc0                                
[<c00bafc8>] (__get_vm_area_node.clone.24+0x0/0x16c) from [<c00bb7b8>] (get_vm_a
rea_caller+0x48/0x54)                                                           
[<c00bb770>] (get_vm_area_caller+0x0/0x54) from [<c0020064>] (__alloc_remap_buff
er.clone.15+0x38/0xb8)                                                          
[<c002002c>] (__alloc_remap_buffer.clone.15+0x0/0xb8) from [<c0020244>] (__dma_a
lloc+0x160/0x2c8)                                                               
 r8:00000000 r7:00002000 r6:00002000 r5:ffffffff r4:ffffffff                    
r3:cf83fc54                                                                     
[<c00200e4>] (__dma_alloc+0x0/0x2c8) from [<c00204d8>] (arm_dma_alloc+0x88/0xa0)
[<c0020450>] (arm_dma_alloc+0x0/0xa0) from [<c00beb00>] (dma_pool_alloc+0xcc/0x1
a8)                                                                             
[<c00bea34>] (dma_pool_alloc+0x0/0x1a8) from [<c01a9d14>] (pl08x_fill_llis_for_d
esc+0x28/0x568)                                                                 
[<c01a9cec>] (pl08x_fill_llis_for_desc+0x0/0x568) from [<c01aab8c>] (pl08x_prep_
slave_sg+0x258/0x3b0)                                                           
[<c01aa934>] (pl08x_prep_slave_sg+0x0/0x3b0) from [<c01c9f74>] (pl011_dma_tx_ref
ill+0x140/0x288)                                                                
[<c01c9e34>] (pl011_dma_tx_refill+0x0/0x288) from [<c01ca748>] (pl011_start_tx+0
xe4/0x120)                                                                      
[<c01ca664>] (pl011_start_tx+0x0/0x120) from [<c01c54a4>] (__uart_start+0x48/0x4
c)                                                                              
 r5:cfa7c400 r4:cf8bde10                                                        
[<c01c545c>] (__uart_start+0x0/0x4c) from [<c01c632c>] (uart_start+0x2c/0x3c)   
[<c01c6300>] (uart_start+0x0/0x3c) from [<c01c795c>] (uart_write+0xcc/0xf4)     
 r6:cfa8b037 r5:cf906000 r4:00000000 r3:cf83d1c0                                
[<c01c7890>] (uart_write+0x0/0xf4) from [<c01b0384>] (n_tty_write+0x1c0/0x3e4)  
[<c01b01c4>] (n_tty_write+0x0/0x3e4) from [<c01acfe8>] (tty_write+0x144/0x240)  
[<c01acea4>] (tty_write+0x0/0x240) from [<c01ad17c>] (redirected_tty_write+0x98/
0xac)                                                                           
[<c01ad0e4>] (redirected_tty_write+0x0/0xac) from [<c00c371c>] (vfs_write+0xbc/0
x150)                                                                           
 r8:00000000 r7:cf83ff70 r6:be83cc04 r5:00000038 r4:cf8b1d80                    
r3:cf83ff70                                                                     
[<c00c3660>] (vfs_write+0x0/0x150) from [<c00c39c0>] (sys_write+0x4c/0x78)      
 r8:00000000 r7:be83cc04 r6:cf83ff70 r5:00000000 r4:cf8b1d80                    
[<c00c3974>] (sys_write+0x0/0x78) from [<c0014460>] (ret_fast_syscall+0x0/0x3c) 

Now, this _used_ to work fine before the DMA code was changed...  What
joy running ARM kernels bring.  Thankfully I hardly ever do that nowadays.
I wonder why that is...
