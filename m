From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Jun 2015 15:02:03 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <20150609200751.GC5720@breakpoint.cc>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150603130825.GA23991@breakpoint.cc>
 <b3b09b4b8c97cbfc88fa0d5fdc5e40cd@agner.ch>
 <20150609200751.GC5720@breakpoint.cc>
Message-ID: <32a7fe8d8df87dfe35ea50c582077c78@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-09 22:07, Sebastian Andrzej Siewior wrote:
> On 2015-06-03 17:05:16 [+0200], Stefan Agner wrote:
>> As Boris guessed correctly, the reason I used the raw variant was due to
>> performance improvements due to the barrier. However, I will use
> 
> yeah, do you have any numbers by chance?
> 

Just reevaluated the "performance optimizations". On a VF610 SoC (with
L2 cache) the improvements increase performance by 2.5% and below. On a
VF500 SoC (without L2 cache) it seems to have slightly more impact, up
to 4%. Overall, it seems to influence write more than read.

Back then, when I implemented the improvements it certainly had a bigger
impact. I don't have strong opinion on that...


=> VF610, with relaxed, optimized
[   45.554246] 
[   45.555934] =================================================
[   45.561762] mtd_speedtest: MTD device: 3
[   45.576627] mtd_speedtest: MTD device size 104857600, eraseblock size
131072, page size 2048, count of eraseblocks 800, pages per eraseblock
64, OOB size 64
[   45.595350] mtd_test: scanning for bad eraseblocks
[   45.602177] mtd_test: scanned 800 eraseblocks, 0 are bad
[   46.404682] mtd_speedtest: testing eraseblock write speed
[   65.650704] mtd_speedtest: eraseblock write speed is 5344 KiB/s
[   65.656738] mtd_speedtest: testing eraseblock read speed
[   73.480687] mtd_speedtest: eraseblock read speed is 13118 KiB/s
[   74.264593] mtd_speedtest: testing page write speed
[   94.444190] mtd_speedtest: page write speed is 5087 KiB/s
[   94.449674] mtd_speedtest: testing page read speed
[  102.760387] mtd_speedtest: page read speed is 12343 KiB/s
[  103.544838] mtd_speedtest: testing 2 page write speed
[  123.257753] mtd_speedtest: 2 page write speed is 5199 KiB/s
[  123.263440] mtd_speedtest: testing 2 page read speed
[  131.171313] mtd_speedtest: 2 page read speed is 12963 KiB/s
[  131.176981] mtd_speedtest: Testing erase speed
[  131.968196] mtd_speedtest: erase speed is 130279 KiB/s
[  131.973442] mtd_speedtest: Testing 2x multi-block erase speed
[  132.153410] mtd_speedtest: 2x multi-block erase speed is 585142 KiB/s
[  132.159924] mtd_speedtest: Testing 4x multi-block erase speed
[  132.334864] mtd_speedtest: 4x multi-block erase speed is 609523 KiB/s
[  132.341369] mtd_speedtest: Testing 8x multi-block erase speed
[  132.516091] mtd_speedtest: 8x multi-block erase speed is 609523 KiB/s
[  132.522602] mtd_speedtest: Testing 16x multi-block erase speed
[  132.695800] mtd_speedtest: 16x multi-block erase speed is 613173
KiB/s
[  132.702389] mtd_speedtest: Testing 32x multi-block erase speed
[  132.874831] mtd_speedtest: 32x multi-block erase speed is 616867
KiB/s
[  132.881445] mtd_speedtest: Testing 64x multi-block erase speed
[  133.053647] mtd_speedtest: 64x multi-block erase speed is 616867
KiB/s
[  133.060267] mtd_speedtest: finished
[  133.063812] =================================================

=> VF610, without relaxed and using accessors
vf610_nfc_set/vf610_nfc_set_field and friends:
[   60.015797] 
[   60.017481] =================================================
[   60.023320] mtd_speedtest: MTD device: 3
[   60.037232] mtd_speedtest: MTD device size 104857600, eraseblock size
131072, page size 2048, count of eraseblocks 800, pages per eraseblock
64, OOB size 64
[   60.066359] mtd_test: scanning for bad eraseblocks
[   60.074016] mtd_test: scanned 800 eraseblocks, 0 are bad
[   60.286730] mtd_speedtest: testing eraseblock write speed
[   79.679892] mtd_speedtest: eraseblock write speed is 5281 KiB/s
[   79.685930] mtd_speedtest: testing eraseblock read speed
[   87.563845] mtd_speedtest: eraseblock read speed is 13008 KiB/s
[   88.353390] mtd_speedtest: testing page write speed
[  108.984528] mtd_speedtest: page write speed is 4965 KiB/s
[  108.990041] mtd_speedtest: testing page read speed
[  117.012486] mtd_speedtest: page read speed is 12774 KiB/s
[  117.801663] mtd_speedtest: testing 2 page write speed
[  137.674009] mtd_speedtest: 2 page write speed is 5154 KiB/s
[  137.679696] mtd_speedtest: testing 2 page read speed
[  145.643303] mtd_speedtest: 2 page read speed is 12865 KiB/s
[  145.648982] mtd_speedtest: Testing erase speed
[  146.444423] mtd_speedtest: erase speed is 129456 KiB/s
[  146.449669] mtd_speedtest: Testing 2x multi-block erase speed
[  146.629634] mtd_speedtest: 2x multi-block erase speed is 588505 KiB/s
[  146.636142] mtd_speedtest: Testing 4x multi-block erase speed
[  146.813027] mtd_speedtest: 4x multi-block erase speed is 598830 KiB/s
[  146.819577] mtd_speedtest: Testing 8x multi-block erase speed
[  146.996654] mtd_speedtest: 8x multi-block erase speed is 595348 KiB/s
[  147.003192] mtd_speedtest: Testing 16x multi-block erase speed
[  147.178085] mtd_speedtest: 16x multi-block erase speed is 609523
KiB/s
[  147.184703] mtd_speedtest: Testing 32x multi-block erase speed
[  147.358306] mtd_speedtest: 32x multi-block erase speed is 613173
KiB/s
[  147.364929] mtd_speedtest: Testing 64x multi-block erase speed
[  147.540505] mtd_speedtest: 64x multi-block erase speed is 605917
KiB/s
[  147.547106] mtd_speedtest: finished
[  147.558336] =================================================

=> VF500, with relaxed, optimized
[   42.878713] 
[   42.880775] =================================================
[   42.886589] mtd_speedtest: MTD device: 3
[   42.933491] mtd_speedtest: MTD device size 132120576, eraseblock size
131072, page size 2048, count of eraseblocks 1008, pages per eraseblock
64, OOB size 64
[   42.981413] mtd_test: scanning for bad eraseblocks
[   42.987505] mtd_test: block 142 is bad
[   43.001342] mtd_test: block 1004 is bad
[   43.024184] mtd_test: block 1005 is bad
[   43.029184] mtd_test: block 1006 is bad
[   43.045070] mtd_test: block 1007 is bad
[   43.048975] mtd_test: scanned 1008 eraseblocks, 5 are bad
[   43.854654] mtd_speedtest: testing eraseblock write speed
[   68.873797] mtd_speedtest: eraseblock write speed is 5150 KiB/s
[   68.879915] mtd_speedtest: testing eraseblock read speed
[   80.409787] mtd_speedtest: eraseblock read speed is 11171 KiB/s
[   81.053244] mtd_speedtest: testing page write speed
[  109.851897] mtd_speedtest: page write speed is 4462 KiB/s
[  109.857496] mtd_speedtest: testing page read speed
[  121.964415] mtd_speedtest: page read speed is 10616 KiB/s
[  122.603068] mtd_speedtest: testing 2 page write speed
[  148.929905] mtd_speedtest: 2 page write speed is 4880 KiB/s
[  148.935696] mtd_speedtest: testing 2 page read speed
[  160.908554] mtd_speedtest: 2 page read speed is 10731 KiB/s
[  160.914236] mtd_speedtest: Testing erase speed
[  161.579429] mtd_speedtest: erase speed is 194226 KiB/s
[  161.584680] mtd_speedtest: Testing 2x multi-block erase speed
[  162.226599] mtd_speedtest: 2x multi-block erase speed is 201861 KiB/s
[  162.233153] mtd_speedtest: Testing 4x multi-block erase speed
[  162.870923] mtd_speedtest: 4x multi-block erase speed is 202818 KiB/s
[  162.877591] mtd_speedtest: Testing 8x multi-block erase speed
[  163.503176] mtd_speedtest: 8x multi-block erase speed is 207070 KiB/s
[  163.509826] mtd_speedtest: Testing 16x multi-block erase speed
[  164.138392] mtd_speedtest: 16x multi-block erase speed is 206405
KiB/s
[  164.145128] mtd_speedtest: Testing 32x multi-block erase speed
[  164.768705] mtd_speedtest: 32x multi-block erase speed is 207741
KiB/s
[  164.775475] mtd_speedtest: Testing 64x multi-block erase speed
[  165.394716] mtd_speedtest: 64x multi-block erase speed is 209094
KiB/s
[  165.401347] mtd_speedtest: finished
[  165.415581] =================================================

=> VF500, without relaxed and using accessors
[   93.466642] 
[   93.468578] =================================================
[   93.474563] mtd_speedtest: MTD device: 3
[   93.510699] mtd_speedtest: MTD device size 132120576, eraseblock size
131072, page size 2048, count of eraseblocks 1008, pages per eraseblock
64, OOB size 64
[   93.534490] mtd_test: scanning for bad eraseblocks
[   93.553066] mtd_test: block 142 is bad
[   93.586518] mtd_test: block 1004 is bad
[   93.590559] mtd_test: block 1005 is bad
[   93.595654] mtd_test: block 1006 is bad
[   93.607090] mtd_test: block 1007 is bad
[   93.630667] mtd_test: scanned 1008 eraseblocks, 5 are bad
[   94.457510] mtd_speedtest: testing eraseblock write speed
[  120.495695] mtd_speedtest: eraseblock write speed is 4932 KiB/s
[  120.501726] mtd_speedtest: testing eraseblock read speed
[  131.937006] mtd_speedtest: eraseblock read speed is 11233 KiB/s
[  132.576468] mtd_speedtest: testing page write speed
[  160.663012] mtd_speedtest: page write speed is 4572 KiB/s
[  160.668608] mtd_speedtest: testing page read speed
[  172.624020] mtd_speedtest: page read speed is 10743 KiB/s
[  173.263221] mtd_speedtest: testing 2 page write speed
[  199.811255] mtd_speedtest: 2 page write speed is 4837 KiB/s
[  199.816933] mtd_speedtest: testing 2 page read speed
[  211.558975] mtd_speedtest: 2 page read speed is 10939 KiB/s
[  211.564657] mtd_speedtest: Testing erase speed
[  212.227608] mtd_speedtest: erase speed is 194816 KiB/s
[  212.232951] mtd_speedtest: Testing 2x multi-block erase speed
[  212.875607] mtd_speedtest: 2x multi-block erase speed is 201544 KiB/s
[  212.882254] mtd_speedtest: Testing 4x multi-block erase speed
[  213.521870] mtd_speedtest: 4x multi-block erase speed is 202818 KiB/s
[  213.528471] mtd_speedtest: Testing 8x multi-block erase speed
[  214.154043] mtd_speedtest: 8x multi-block erase speed is 207070 KiB/s
[  214.160690] mtd_speedtest: Testing 16x multi-block erase speed
[  214.785910] mtd_speedtest: 16x multi-block erase speed is 207405
KiB/s
[  214.792652] mtd_speedtest: Testing 32x multi-block erase speed
[  215.418150] mtd_speedtest: 32x multi-block erase speed is 207405
KiB/s
[  215.424883] mtd_speedtest: Testing 64x multi-block erase speed
[  216.051367] mtd_speedtest: 64x multi-block erase speed is 206737
KiB/s
[  216.058056] mtd_speedtest: finished
[  216.069363] =================================================

--
Stefan
