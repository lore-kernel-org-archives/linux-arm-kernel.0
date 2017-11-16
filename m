From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 16 Nov 2017 13:21:00 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <bed48cd4-dfc3-2572-ef76-4f5b449be6e2@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
 <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
 <yw1xbmk4241h.fsf@mansr.com>
 <a047ecbd-c8a2-a8c0-7c9d-947b28aa8b9a@sigmadesigns.com>
 <yw1xr2szzie5.fsf@mansr.com>
 <bed48cd4-dfc3-2572-ef76-4f5b449be6e2@sigmadesigns.com>
Message-ID: <691f71bc-9e1b-5281-1482-fc532151f5ce@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2017 17:15, Marc Gonzalez wrote:

> Given the out-of-order datagrams, I'm wondering if it's possible
> for the DMA engine to overwrite a not-yet-read descriptor?
> 
> The EOC flag should stop the DMA engine though...
> 
> Maybe some kind of race...
> 
> I don't think I've been able to trigger the wedge when 256 descriptors
> are used.

I'm still taking stabs in the dark.

Adding a 10 ms delay for every 1024 packets, and using 256 descriptors
doesn't cause any hang, even after an hour.

At 85 packets per ms, 10 ms is large enough to consume all available
descriptors... Yet no issue.

Only when I lower the number of available RX descriptors do I see
the issue. And I don't need any delay...

I'm starting to think there is some kind of race condition between
SW and HW handling of descriptors. This might also explain the
out-of-order warnings.

Lowering the number of RX descriptors to 64, and adding no delay
causes many OUT OF ORDER warnings, and the network locks up in
under a minute:


iperf3: OUT OF ORDER - incoming packet = 13031 and received packet = 0 AND SP = 13094
iperf3: OUT OF ORDER - incoming packet = 21441 and received packet = 0 AND SP = 21504
iperf3: OUT OF ORDER - incoming packet = 21442 and received packet = 0 AND SP = 21504
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  97.4 MBytes   817 Mbits/sec  0.016 ms  8793/81753 (11%)  
iperf3: OUT OF ORDER - incoming packet = 92503 and received packet = 0 AND SP = 92566
iperf3: OUT OF ORDER - incoming packet = 92504 and received packet = 0 AND SP = 92566
iperf3: OUT OF ORDER - incoming packet = 125503 and received packet = 0 AND SP = 125566
[  5]   1.00-2.00   sec   101 MBytes   851 Mbits/sec  0.011 ms  8835/84797 (10%)  
iperf3: OUT OF ORDER - incoming packet = 198710 and received packet = 0 AND SP = 198773
iperf3: OUT OF ORDER - incoming packet = 243272 and received packet = 0 AND SP = 243335
iperf3: OUT OF ORDER - incoming packet = 243791 and received packet = 0 AND SP = 243854
[  5]   2.00-3.00   sec   101 MBytes   851 Mbits/sec  0.016 ms  8771/84782 (10%)  
iperf3: OUT OF ORDER - incoming packet = 294545 and received packet = 0 AND SP = 294608
iperf3: OUT OF ORDER - incoming packet = 301719 and received packet = 0 AND SP = 301782
iperf3: OUT OF ORDER - incoming packet = 301720 and received packet = 0 AND SP = 301782
iperf3: OUT OF ORDER - incoming packet = 305218 and received packet = 0 AND SP = 305281
iperf3: OUT OF ORDER - incoming packet = 314655 and received packet = 0 AND SP = 314718
iperf3: OUT OF ORDER - incoming packet = 325473 and received packet = 0 AND SP = 325536
iperf3: OUT OF ORDER - incoming packet = 325474 and received packet = 0 AND SP = 325536
[  5]   3.00-4.00   sec   101 MBytes   850 Mbits/sec  0.013 ms  8903/84798 (10%)  
iperf3: OUT OF ORDER - incoming packet = 340919 and received packet = 0 AND SP = 340982
iperf3: OUT OF ORDER - incoming packet = 340920 and received packet = 0 AND SP = 340982
iperf3: OUT OF ORDER - incoming packet = 346325 and received packet = 0 AND SP = 346388
iperf3: OUT OF ORDER - incoming packet = 346326 and received packet = 0 AND SP = 346388
[  5]   4.00-5.00   sec   101 MBytes   851 Mbits/sec  0.012 ms  8868/84829 (10%)  
iperf3: OUT OF ORDER - incoming packet = 441873 and received packet = 0 AND SP = 441936
iperf3: OUT OF ORDER - incoming packet = 459258 and received packet = 0 AND SP = 459321
iperf3: OUT OF ORDER - incoming packet = 495604 and received packet = 0 AND SP = 495667
[  5]   5.00-6.00   sec   101 MBytes   850 Mbits/sec  0.013 ms  8835/84760 (10%)  
iperf3: OUT OF ORDER - incoming packet = 558280 and received packet = 0 AND SP = 558343
iperf3: OUT OF ORDER - incoming packet = 558281 and received packet = 0 AND SP = 558343
iperf3: OUT OF ORDER - incoming packet = 587445 and received packet = 0 AND SP = 587508
iperf3: OUT OF ORDER - incoming packet = 587446 and received packet = 0 AND SP = 587508
[  5]   6.00-7.00   sec   102 MBytes   854 Mbits/sec  0.016 ms  8580/84843 (10%)  
iperf3: OUT OF ORDER - incoming packet = 617324 and received packet = 0 AND SP = 617387
iperf3: OUT OF ORDER - incoming packet = 620412 and received packet = 0 AND SP = 620475
iperf3: OUT OF ORDER - incoming packet = 635845 and received packet = 0 AND SP = 635908
iperf3: OUT OF ORDER - incoming packet = 657102 and received packet = 0 AND SP = 657165
iperf3: OUT OF ORDER - incoming packet = 670672 and received packet = 0 AND SP = 670735
iperf3: OUT OF ORDER - incoming packet = 670673 and received packet = 0 AND SP = 670735
[  5]   7.00-8.00   sec   102 MBytes   853 Mbits/sec  0.012 ms  8582/84757 (10%)  
iperf3: OUT OF ORDER - incoming packet = 676529 and received packet = 0 AND SP = 676592
iperf3: OUT OF ORDER - incoming packet = 682693 and received packet = 0 AND SP = 682756
iperf3: OUT OF ORDER - incoming packet = 682694 and received packet = 0 AND SP = 682756
iperf3: OUT OF ORDER - incoming packet = 690106 and received packet = 0 AND SP = 690169
iperf3: OUT OF ORDER - incoming packet = 694369 and received packet = 0 AND SP = 694432
iperf3: OUT OF ORDER - incoming packet = 715288 and received packet = 0 AND SP = 715351
iperf3: OUT OF ORDER - incoming packet = 715289 and received packet = 0 AND SP = 715351
iperf3: OUT OF ORDER - incoming packet = 731162 and received packet = 0 AND SP = 731225
iperf3: OUT OF ORDER - incoming packet = 731163 and received packet = 0 AND SP = 731225
iperf3: OUT OF ORDER - incoming packet = 750282 and received packet = 0 AND SP = 750345
iperf3: OUT OF ORDER - incoming packet = 752731 and received packet = 0 AND SP = 752794
[  5]   8.00-9.00   sec   102 MBytes   853 Mbits/sec  0.011 ms  8651/84784 (10%)  
iperf3: OUT OF ORDER - incoming packet = 786352 and received packet = 0 AND SP = 786415
iperf3: OUT OF ORDER - incoming packet = 786353 and received packet = 0 AND SP = 786415
iperf3: OUT OF ORDER - incoming packet = 801154 and received packet = 0 AND SP = 801217
iperf3: OUT OF ORDER - incoming packet = 803611 and received packet = 0 AND SP = 803674
iperf3: OUT OF ORDER - incoming packet = 803612 and received packet = 0 AND SP = 803674
iperf3: OUT OF ORDER - incoming packet = 809297 and received packet = 0 AND SP = 809360
iperf3: OUT OF ORDER - incoming packet = 821889 and received packet = 0 AND SP = 821952
iperf3: OUT OF ORDER - incoming packet = 828216 and received packet = 0 AND SP = 828279
iperf3: OUT OF ORDER - incoming packet = 828217 and received packet = 0 AND SP = 828279
iperf3: OUT OF ORDER - incoming packet = 830446 and received packet = 0 AND SP = 830509
[  5]   9.00-10.00  sec   102 MBytes   854 Mbits/sec  0.010 ms  8590/84807 (10%)  
iperf3: OUT OF ORDER - incoming packet = 863210 and received packet = 0 AND SP = 863273
iperf3: OUT OF ORDER - incoming packet = 863211 and received packet = 0 AND SP = 863273
iperf3: OUT OF ORDER - incoming packet = 870942 and received packet = 0 AND SP = 871005
iperf3: OUT OF ORDER - incoming packet = 870943 and received packet = 0 AND SP = 871005
iperf3: OUT OF ORDER - incoming packet = 900170 and received packet = 0 AND SP = 900233
iperf3: OUT OF ORDER - incoming packet = 919395 and received packet = 0 AND SP = 919458
iperf3: OUT OF ORDER - incoming packet = 919396 and received packet = 0 AND SP = 919458
[  5]  10.00-11.00  sec   102 MBytes   855 Mbits/sec  0.013 ms  8455/84823 (10%)  
iperf3: OUT OF ORDER - incoming packet = 973534 and received packet = 0 AND SP = 973597
iperf3: OUT OF ORDER - incoming packet = 1011487 and received packet = 0 AND SP = 1011550
[  5]  11.00-12.00  sec   102 MBytes   856 Mbits/sec  0.015 ms  8322/84753 (9.8%)  
iperf3: OUT OF ORDER - incoming packet = 1050138 and received packet = 0 AND SP = 1050201
iperf3: OUT OF ORDER - incoming packet = 1050139 and received packet = 0 AND SP = 1050201
[  5]  12.00-13.00  sec   102 MBytes   855 Mbits/sec  0.010 ms  8450/84812 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1099930 and received packet = 0 AND SP = 1099993
iperf3: OUT OF ORDER - incoming packet = 1123640 and received packet = 0 AND SP = 1123703
iperf3: OUT OF ORDER - incoming packet = 1123641 and received packet = 0 AND SP = 1123703
iperf3: OUT OF ORDER - incoming packet = 1132657 and received packet = 0 AND SP = 1132720
iperf3: OUT OF ORDER - incoming packet = 1132658 and received packet = 0 AND SP = 1132720
iperf3: OUT OF ORDER - incoming packet = 1149744 and received packet = 0 AND SP = 1149807
iperf3: OUT OF ORDER - incoming packet = 1149745 and received packet = 0 AND SP = 1149807
iperf3: OUT OF ORDER - incoming packet = 1165178 and received packet = 0 AND SP = 1165241
[  5]  13.00-14.00  sec   102 MBytes   855 Mbits/sec  0.010 ms  8509/84818 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1186134 and received packet = 0 AND SP = 1186197
iperf3: OUT OF ORDER - incoming packet = 1191699 and received packet = 0 AND SP = 1191762
iperf3: OUT OF ORDER - incoming packet = 1206111 and received packet = 0 AND SP = 1206174
iperf3: OUT OF ORDER - incoming packet = 1206112 and received packet = 0 AND SP = 1206174
iperf3: OUT OF ORDER - incoming packet = 1210586 and received packet = 0 AND SP = 1210649
[  5]  14.00-15.00  sec   102 MBytes   855 Mbits/sec  0.022 ms  8460/84786 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1307589 and received packet = 0 AND SP = 1307652
iperf3: OUT OF ORDER - incoming packet = 1314198 and received packet = 0 AND SP = 1314261
iperf3: OUT OF ORDER - incoming packet = 1345142 and received packet = 0 AND SP = 1345205
[  5]  15.00-16.00  sec   102 MBytes   857 Mbits/sec  0.011 ms  8248/84782 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 1359295 and received packet = 0 AND SP = 1359358
iperf3: OUT OF ORDER - incoming packet = 1413394 and received packet = 0 AND SP = 1413457
iperf3: OUT OF ORDER - incoming packet = 1413395 and received packet = 0 AND SP = 1413457
iperf3: OUT OF ORDER - incoming packet = 1423771 and received packet = 0 AND SP = 1423834
iperf3: OUT OF ORDER - incoming packet = 1423772 and received packet = 0 AND SP = 1423834
[  5]  16.00-17.00  sec   102 MBytes   858 Mbits/sec  0.018 ms  8197/84768 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 1441628 and received packet = 0 AND SP = 1441691
iperf3: OUT OF ORDER - incoming packet = 1500381 and received packet = 0 AND SP = 1500444
iperf3: OUT OF ORDER - incoming packet = 1500382 and received packet = 0 AND SP = 1500444
[  5]  17.00-18.00  sec   102 MBytes   856 Mbits/sec  0.012 ms  8387/84849 (9.9%)  
iperf3: OUT OF ORDER - incoming packet = 1524208 and received packet = 0 AND SP = 1524271
iperf3: OUT OF ORDER - incoming packet = 1525402 and received packet = 0 AND SP = 1525465
iperf3: OUT OF ORDER - incoming packet = 1525403 and received packet = 0 AND SP = 1525465
iperf3: OUT OF ORDER - incoming packet = 1549050 and received packet = 0 AND SP = 1549113
iperf3: OUT OF ORDER - incoming packet = 1549051 and received packet = 0 AND SP = 1549113
iperf3: OUT OF ORDER - incoming packet = 1581586 and received packet = 0 AND SP = 1581649
iperf3: OUT OF ORDER - incoming packet = 1581587 and received packet = 0 AND SP = 1581649
[  5]  18.00-19.00  sec   102 MBytes   854 Mbits/sec  0.012 ms  8519/84776 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1614525 and received packet = 0 AND SP = 1614588
iperf3: OUT OF ORDER - incoming packet = 1614526 and received packet = 0 AND SP = 1614588
iperf3: OUT OF ORDER - incoming packet = 1631851 and received packet = 0 AND SP = 1631914
iperf3: OUT OF ORDER - incoming packet = 1631852 and received packet = 0 AND SP = 1631914
iperf3: OUT OF ORDER - incoming packet = 1632403 and received packet = 0 AND SP = 1632466
iperf3: OUT OF ORDER - incoming packet = 1668834 and received packet = 0 AND SP = 1668897
[  5]  19.00-20.00  sec   102 MBytes   854 Mbits/sec  0.012 ms  8507/84777 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1710901 and received packet = 0 AND SP = 1710964
iperf3: OUT OF ORDER - incoming packet = 1710902 and received packet = 0 AND SP = 1710964
iperf3: OUT OF ORDER - incoming packet = 1743216 and received packet = 0 AND SP = 1743279
iperf3: OUT OF ORDER - incoming packet = 1743217 and received packet = 0 AND SP = 1743279
[  5]  20.00-21.00  sec   102 MBytes   856 Mbits/sec  0.011 ms  8452/84842 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1801411 and received packet = 0 AND SP = 1801474
iperf3: OUT OF ORDER - incoming packet = 1801412 and received packet = 0 AND SP = 1801474
iperf3: OUT OF ORDER - incoming packet = 1828046 and received packet = 0 AND SP = 1828109
[  5]  21.00-22.00  sec   102 MBytes   855 Mbits/sec  0.013 ms  8451/84819 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1872009 and received packet = 0 AND SP = 1872072
iperf3: OUT OF ORDER - incoming packet = 1907637 and received packet = 0 AND SP = 1907700
iperf3: OUT OF ORDER - incoming packet = 1920279 and received packet = 0 AND SP = 1920342
iperf3: OUT OF ORDER - incoming packet = 1920280 and received packet = 0 AND SP = 1920342
[  5]  22.00-23.00  sec   102 MBytes   853 Mbits/sec  0.017 ms  8633/84757 (10%)  
iperf3: OUT OF ORDER - incoming packet = 1958806 and received packet = 0 AND SP = 1958869
iperf3: OUT OF ORDER - incoming packet = 1960612 and received packet = 0 AND SP = 1960675
iperf3: OUT OF ORDER - incoming packet = 1960613 and received packet = 0 AND SP = 1960675
iperf3: OUT OF ORDER - incoming packet = 1971512 and received packet = 0 AND SP = 1971575
iperf3: OUT OF ORDER - incoming packet = 1971513 and received packet = 0 AND SP = 1971575
iperf3: OUT OF ORDER - incoming packet = 1974598 and received packet = 0 AND SP = 1974661
iperf3: OUT OF ORDER - incoming packet = 1974599 and received packet = 0 AND SP = 1974661
iperf3: OUT OF ORDER - incoming packet = 2020663 and received packet = 0 AND SP = 2020726
[  5]  23.00-24.00  sec   102 MBytes   854 Mbits/sec  0.012 ms  8583/84833 (10%)  
iperf3: OUT OF ORDER - incoming packet = 2048932 and received packet = 0 AND SP = 2048995
iperf3: OUT OF ORDER - incoming packet = 2059769 and received packet = 0 AND SP = 2059832
iperf3: OUT OF ORDER - incoming packet = 2069989 and received packet = 0 AND SP = 2070052
iperf3: OUT OF ORDER - incoming packet = 2069990 and received packet = 0 AND SP = 2070052
iperf3: OUT OF ORDER - incoming packet = 2073023 and received packet = 0 AND SP = 2073086
iperf3: OUT OF ORDER - incoming packet = 2083300 and received packet = 0 AND SP = 2083363
iperf3: OUT OF ORDER - incoming packet = 2083301 and received packet = 0 AND SP = 2083363
iperf3: OUT OF ORDER - incoming packet = 2087583 and received packet = 0 AND SP = 2087646
iperf3: OUT OF ORDER - incoming packet = 2089400 and received packet = 0 AND SP = 2089463
iperf3: OUT OF ORDER - incoming packet = 2089401 and received packet = 0 AND SP = 2089463
iperf3: OUT OF ORDER - incoming packet = 2091835 and received packet = 0 AND SP = 2091898
iperf3: OUT OF ORDER - incoming packet = 2091836 and received packet = 0 AND SP = 2091898
iperf3: OUT OF ORDER - incoming packet = 2112610 and received packet = 0 AND SP = 2112673
[  5]  24.00-25.00  sec   102 MBytes   853 Mbits/sec  0.012 ms  8589/84768 (10%)  
iperf3: OUT OF ORDER - incoming packet = 2167633 and received packet = 0 AND SP = 2167696
iperf3: OUT OF ORDER - incoming packet = 2177652 and received packet = 0 AND SP = 2177715
iperf3: OUT OF ORDER - incoming packet = 2177653 and received packet = 0 AND SP = 2177715
[  5]  25.00-26.00  sec   102 MBytes   854 Mbits/sec  0.022 ms  8633/84853 (10%)  
iperf3: OUT OF ORDER - incoming packet = 2267485 and received packet = 0 AND SP = 2267548
iperf3: OUT OF ORDER - incoming packet = 2267486 and received packet = 0 AND SP = 2267548
[  5]  26.00-27.00  sec   102 MBytes   857 Mbits/sec  0.011 ms  8258/84791 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 2287486 and received packet = 0 AND SP = 2287549
iperf3: OUT OF ORDER - incoming packet = 2287487 and received packet = 0 AND SP = 2287549
iperf3: OUT OF ORDER - incoming packet = 2308286 and received packet = 0 AND SP = 2308349
iperf3: OUT OF ORDER - incoming packet = 2347272 and received packet = 0 AND SP = 2347335
iperf3: OUT OF ORDER - incoming packet = 2347273 and received packet = 0 AND SP = 2347335
iperf3: OUT OF ORDER - incoming packet = 2354962 and received packet = 0 AND SP = 2355025
iperf3: OUT OF ORDER - incoming packet = 2354963 and received packet = 0 AND SP = 2355025
iperf3: OUT OF ORDER - incoming packet = 2369466 and received packet = 0 AND SP = 2369529
[  5]  27.00-28.00  sec   102 MBytes   856 Mbits/sec  0.014 ms  8317/84758 (9.8%)  
iperf3: OUT OF ORDER - incoming packet = 2380936 and received packet = 0 AND SP = 2380999
iperf3: OUT OF ORDER - incoming packet = 2380937 and received packet = 0 AND SP = 2380999
iperf3: OUT OF ORDER - incoming packet = 2384122 and received packet = 0 AND SP = 2384185
iperf3: OUT OF ORDER - incoming packet = 2398106 and received packet = 0 AND SP = 2398169
iperf3: OUT OF ORDER - incoming packet = 2407507 and received packet = 0 AND SP = 2407570
[  5]  28.00-29.00  sec   102 MBytes   858 Mbits/sec  0.011 ms  8261/84849 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 2463519 and received packet = 0 AND SP = 2463582
iperf3: OUT OF ORDER - incoming packet = 2463520 and received packet = 0 AND SP = 2463582
iperf3: OUT OF ORDER - incoming packet = 2490271 and received packet = 0 AND SP = 2490334
iperf3: OUT OF ORDER - incoming packet = 2490272 and received packet = 0 AND SP = 2490334
iperf3: OUT OF ORDER - incoming packet = 2498122 and received packet = 0 AND SP = 2498185
iperf3: OUT OF ORDER - incoming packet = 2514674 and received packet = 0 AND SP = 2514737
iperf3: OUT OF ORDER - incoming packet = 2514675 and received packet = 0 AND SP = 2514737
iperf3: OUT OF ORDER - incoming packet = 2517846 and received packet = 0 AND SP = 2517909
[  5]  29.00-30.00  sec   102 MBytes   857 Mbits/sec  0.011 ms  8262/84806 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 2546398 and received packet = 0 AND SP = 2546461
iperf3: OUT OF ORDER - incoming packet = 2546399 and received packet = 0 AND SP = 2546461
iperf3: OUT OF ORDER - incoming packet = 2558838 and received packet = 0 AND SP = 2558901
iperf3: OUT OF ORDER - incoming packet = 2572958 and received packet = 0 AND SP = 2573021
iperf3: OUT OF ORDER - incoming packet = 2572959 and received packet = 0 AND SP = 2573021
iperf3: OUT OF ORDER - incoming packet = 2586545 and received packet = 0 AND SP = 2586608
iperf3: OUT OF ORDER - incoming packet = 2586546 and received packet = 0 AND SP = 2586608
iperf3: OUT OF ORDER - incoming packet = 2621613 and received packet = 0 AND SP = 2621676
[  5]  30.00-31.00  sec   102 MBytes   858 Mbits/sec  0.011 ms  8200/84785 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 2629982 and received packet = 0 AND SP = 2630045
iperf3: OUT OF ORDER - incoming packet = 2629983 and received packet = 0 AND SP = 2630045
iperf3: OUT OF ORDER - incoming packet = 2672925 and received packet = 0 AND SP = 2672988
iperf3: OUT OF ORDER - incoming packet = 2676140 and received packet = 0 AND SP = 2676203
iperf3: OUT OF ORDER - incoming packet = 2688740 and received packet = 0 AND SP = 2688803
iperf3: OUT OF ORDER - incoming packet = 2688741 and received packet = 0 AND SP = 2688803
iperf3: OUT OF ORDER - incoming packet = 2697968 and received packet = 0 AND SP = 2698031
[  5]  31.00-32.00  sec   102 MBytes   858 Mbits/sec  0.011 ms  8199/84780 (9.7%)  
iperf3: OUT OF ORDER - incoming packet = 2764257 and received packet = 0 AND SP = 2764320
iperf3: OUT OF ORDER - incoming packet = 2770960 and received packet = 0 AND SP = 2771023
iperf3: OUT OF ORDER - incoming packet = 2783857 and received packet = 0 AND SP = 2783920
[  5]  32.00-33.00  sec   102 MBytes   852 Mbits/sec  0.014 ms  8771/84809 (10%)  
[  5]  33.00-34.00  sec   101 MBytes   849 Mbits/sec  0.011 ms  8707/84542 (10%)  
iperf3: OUT OF ORDER - incoming packet = 2913446 and received packet = 0 AND SP = 2913509
iperf3: OUT OF ORDER - incoming packet = 2927697 and received packet = 0 AND SP = 2927760
iperf3: OUT OF ORDER - incoming packet = 2927698 and received packet = 0 AND SP = 2927760
[  5]  34.00-35.00  sec   102 MBytes   852 Mbits/sec  0.012 ms  8771/84799 (10%)  
iperf3: OUT OF ORDER - incoming packet = 3038091 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038092 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038093 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038094 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038095 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038096 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038097 and received packet = 0 AND SP = 3038250
iperf3: OUT OF ORDER - incoming packet = 3038098 and received packet = 0 AND SP = 3038250
[  5]  35.00-36.00  sec  88.0 MBytes   738 Mbits/sec  0.087 ms  7732/73605 (11%)  
[  5]  36.00-37.00  sec  0.00 Bytes  0.00 bits/sec  0.087 ms  0/0 (0%)  
[  5]  37.00-38.00  sec  0.00 Bytes  0.00 bits/sec  0.087 ms  0/0 (0%)  
...
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-42.30  sec  0.00 Bytes  0.00 bits/sec  0.087 ms  306281/3038250 (10%)  
[SUM]  0.0-42.3 sec  189 datagrams received out-of-order
iperf3: interrupt - the server has terminated




Lowering the sender's bitrate to 500 Mbps also leads to an
even faster lock up.

iperf3: OUT OF ORDER - incoming packet = 34566 and received packet = 0 AND SP = 34629
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  49.5 MBytes   415 Mbits/sec  0.010 ms  3947/41030 (9.6%)  
iperf3: OUT OF ORDER - incoming packet = 76093 and received packet = 0 AND SP = 76156
iperf3: OUT OF ORDER - incoming packet = 76094 and received packet = 0 AND SP = 76156
[  5]   1.00-2.00   sec  54.7 MBytes   459 Mbits/sec  0.011 ms  4019/44998 (8.9%)  
iperf3: OUT OF ORDER - incoming packet = 98670 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98671 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98672 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98673 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98674 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98675 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98676 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98677 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98582 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98583 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98584 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98585 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98586 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98587 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98588 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98589 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98590 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98591 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98592 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98593 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98594 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98595 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98596 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98597 and received packet = 0 AND SP = 98733
iperf3: OUT OF ORDER - incoming packet = 98598 and received packet = 0 AND SP = 98733
[  5]   2.00-3.00   sec  15.4 MBytes   129 Mbits/sec  0.049 ms  1160/12705 (9.1%)  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec  0.049 ms  0/0 (0%)  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec  0.049 ms  0/0 (0%)  
...
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-10.71  sec  0.00 Bytes  0.00 bits/sec  0.049 ms  9126/98733 (9.2%)  
[SUM]  0.0-10.7 sec  28 datagrams received out-of-order
iperf3: interrupt - the server has terminated



Even faster with sender @ 200 Mbps

iperf3: OUT OF ORDER - incoming packet = 3451 and received packet = 0 AND SP = 3514
iperf3: OUT OF ORDER - incoming packet = 3452 and received packet = 0 AND SP = 3514
iperf3: OUT OF ORDER - incoming packet = 8736 and received packet = 0 AND SP = 8799
[   15.299039] random: crng init done
iperf3: OUT OF ORDER - incoming packet = 12813 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12814 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12815 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12816 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12817 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12818 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12819 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12820 and received packet = 0 AND SP = 12876
iperf3: OUT OF ORDER - incoming packet = 12821 and received packet = 0 AND SP = 12876
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  15.5 MBytes   130 Mbits/sec  0.051 ms  1267/12876 (9.8%)  
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec  0.051 ms  0/0 (0%)  
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec  0.051 ms  0/0 (0%)  
...
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-7.58   sec  0.00 Bytes  0.00 bits/sec  0.051 ms  1267/12876 (9.8%)  
[SUM]  0.0- 7.6 sec  12 datagrams received out-of-order
iperf3: interrupt - the server has terminated


Same problem with sender @ 80 Mbps


Increasing RX descriptors to 128... Cannot reproduce anymore...

Setting RX descriptors back to 64...

Keep digging...
