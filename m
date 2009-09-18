From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Fri, 18 Sep 2009 20:30:37 +0400
Subject: [PATCH] SA1100: initialise spinlock in DMA code
Message-ID: <1253291437-16452-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare it using DEFINE_SPINLOCK()

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This is a fix for following crash (observed with out-of-tree UDC driver):

BUG: spinlock bad magic on CPU#0, swapper/1                                     
 lock: c02fb3d8, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0             
Backtrace:                                                                      
[<c002c944>] (dump_backtrace+0x0/0x114) from [<c0230898>] (dump_stack+0x1c/0x20)
 r7:00000030 r6:c02ab24d r5:c02fb3d8 r4:00000000                                
[<c023087c>] (dump_stack+0x0/0x20) from [<c012a028>] (spin_bug+0x90/0xa4)       
[<c0129f98>] (spin_bug+0x0/0xa4) from [<c012a150>] (_raw_spin_lock+0x28/0x150)  
 r6:c02fb3d8 r5:c02fb3d8 r4:00000000                                            
[<c012a128>] (_raw_spin_lock+0x0/0x150) from [<c02335a0>] (_spin_lock+0x44/0x4c)
[<c023355c>] (_spin_lock+0x0/0x4c) from [<c00318d8>] (sa1100_request_dma+0x38/0x
148)                                                                            
 r5:c02f02d8 r4:00000000                                                        
[<c00318a0>] (sa1100_request_dma+0x0/0x148) from [<c0019018>] (sa1100_udc_probe+
0x11c/0x240)                                                                    
[<c0018efc>] (sa1100_udc_probe+0x0/0x240) from [<c0162dcc>] (platform_drv_probe+
0x24/0x28)                                                                      
 r8:c02eca6c r7:c02f02a4 r6:c02f02a4 r5:c02d8c0c r4:c02d8c0c                    
[<c0162da8>] (platform_drv_probe+0x0/0x28) from [<c0161d60>] (driver_probe_devic
e+0xb4/0x184)                                                                   
[<c0161cac>] (driver_probe_device+0x0/0x184) from [<c0161e98>] (__driver_attach+
0x68/0x88)                                                                      
 r7:c1c0fee8 r6:c02f02a4 r5:c02d8c40 r4:c02d8c0c                                
[<c0161e30>] (__driver_attach+0x0/0x88) from [<c01615a0>] (bus_for_each_dev+0x60
/0xa0)                                                                          
 r6:c02f02a4 r5:c0161e30 r4:00000000                                            
[<c0161540>] (bus_for_each_dev+0x0/0xa0) from [<c0161bc0>] (driver_attach+0x24/0
x2c)                                                                            
 r7:c1e14180 r6:c02f02a4 r5:c02f02a4 r4:000080d1                                
[<c0161b9c>] (driver_attach+0x0/0x2c) from [<c0160de0>] (bus_add_driver+0xac/0x2
1c)                                                                             
[<c0160d34>] (bus_add_driver+0x0/0x21c) from [<c01621dc>] (driver_register+0xc8/
0x158)                                                                          
[<c0162114>] (driver_register+0x0/0x158) from [<c016332c>] (platform_driver_regi
ster+0x50/0x64)                                                                 
 r8:00000000 r7:00000000 r6:c0018e7c r5:c02f0288 r4:000080d1                    
[<c01632dc>] (platform_driver_register+0x0/0x64) from [<c016335c>] (platform_dri
ver_probe+0x1c/0x90)                                                            
[<c0163340>] (platform_driver_probe+0x0/0x90) from [<c0018ed8>] (udc_init+0x5c/0
x80)                                                                            
 r6:c0018e7c r5:c002125c r4:000080d1                                            
[<c0018e7c>] (udc_init+0x0/0x80) from [<c002831c>] (do_one_initcall+0x7c/0x1ec) 
 r4:c00211cc                                                                    
[<c00282a0>] (do_one_initcall+0x0/0x1ec) from [<c00085e4>] (kernel_init+0x9c/0x1
10)                                                                             
 r8:00000000 r7:00000000 r6:00000000 r5:c002125c r4:c00211cc                    
[<c0008548>] (kernel_init+0x0/0x110) from [<c00457bc>] (do_exit+0x0/0x5c8)      
 r5:00000000 r4:00000000                                                        
BUG: spinlock lockup on CPU#0, swapper/1, c02fb3d8                              
Backtrace:                                                                      
[<c002c944>] (dump_backtrace+0x0/0x114) from [<c0230898>] (dump_stack+0x1c/0x20)
 r7:c1c0e000 r6:c02fb3d8 r5:00000000 r4:00000000                                
[<c023087c>] (dump_stack+0x0/0x20) from [<c012a23c>] (_raw_spin_lock+0x114/0x150
)                                                                               
[<c012a128>] (_raw_spin_lock+0x0/0x150) from [<c02335a0>] (_spin_lock+0x44/0x4c)
[<c023355c>] (_spin_lock+0x0/0x4c) from [<c00318d8>] (sa1100_request_dma+0x38/0x
148)                                                                            
 r5:c02f02d8 r4:00000000                                                        
[<c00318a0>] (sa1100_request_dma+0x0/0x148) from [<c0019018>] (sa1100_udc_probe+
0x11c/0x240)                                                                    
[<c0018efc>] (sa1100_udc_probe+0x0/0x240) from [<c0162dcc>] (platform_drv_probe+
0x24/0x28)                                                                      
 r8:c02eca6c r7:c02f02a4 r6:c02f02a4 r5:c02d8c0c r4:c02d8c0c                    
[<c0162da8>] (platform_drv_probe+0x0/0x28) from [<c0161d60>] (driver_probe_devic
e+0xb4/0x184)                                                                   
[<c0161cac>] (driver_probe_device+0x0/0x184) from [<c0161e98>] (__driver_attach+
0x68/0x88)                                                                      
 r7:c1c0fee8 r6:c02f02a4 r5:c02d8c40 r4:c02d8c0c                                
[<c0161e30>] (__driver_attach+0x0/0x88) from [<c01615a0>] (bus_for_each_dev+0x60
/0xa0)                                                                          
 r6:c02f02a4 r5:c0161e30 r4:00000000                                            
[<c0161540>] (bus_for_each_dev+0x0/0xa0) from [<c0161bc0>] (driver_attach+0x24/0
x2c)                                                                            
 r7:c1e14180 r6:c02f02a4 r5:c02f02a4 r4:000080d1                                
[<c0161b9c>] (driver_attach+0x0/0x2c) from [<c0160de0>] (bus_add_driver+0xac/0x2
1c)                                                                             
[<c0160d34>] (bus_add_driver+0x0/0x21c) from [<c01621dc>] (driver_register+0xc8/
0x158)                                                                          
[<c0162114>] (driver_register+0x0/0x158) from [<c016332c>] (platform_driver_regi
ster+0x50/0x64)                                                                 
 r8:00000000 r7:00000000 r6:c0018e7c r5:c02f0288 r4:000080d1                    
[<c01632dc>] (platform_driver_register+0x0/0x64) from [<c016335c>] (platform_dri
ver_probe+0x1c/0x90)                                                            
[<c0163340>] (platform_driver_probe+0x0/0x90) from [<c0018ed8>] (udc_init+0x5c/0
x80)                                                                            
 r6:c0018e7c r5:c002125c r4:000080d1                                            
[<c0018e7c>] (udc_init+0x0/0x80) from [<c002831c>] (do_one_initcall+0x7c/0x1ec) 
 r4:c00211cc                                                                    
[<c00282a0>] (do_one_initcall+0x0/0x1ec) from [<c00085e4>] (kernel_init+0x9c/0x1
10)                                                                             
 r8:00000000 r7:00000000 r6:00000000 r5:c002125c r4:c00211cc                    
[<c0008548>] (kernel_init+0x0/0x110) from [<c00457bc>] (do_exit+0x0/0x5c8)      
 r5:00000000 r4:00000000  


diff --git a/arch/arm/mach-sa1100/dma.c b/arch/arm/mach-sa1100/dma.c
index 95f9c5a..cb4521a 100644
--- a/arch/arm/mach-sa1100/dma.c
+++ b/arch/arm/mach-sa1100/dma.c
@@ -39,7 +39,7 @@ typedef struct {
 
 static sa1100_dma_t dma_chan[SA1100_DMA_CHANNELS];
 
-static spinlock_t dma_list_lock;
+static DEFINE_SPINLOCK(dma_list_lock);
 
 
 static irqreturn_t dma_irq_handler(int irq, void *dev_id)
-- 
1.6.3.4
