From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Apr 2018 16:17:32 +0100
Subject: 4.16 OMAP serial transmit corruption?
Message-ID: <20180416151732.GU16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not entirely sure what's going on, but I see corrupted characters
with the serial console on the OMAP4430 SDP board.  During boot,
everything seems fine, the problem appears to be userspace output.

For example, if I edit a file, then quit vi:

:q??%??B??Z?root at omap-4430sdp:~#

The hexdump of that is:

00000000  1b 5b 32 35 3b 31 48 1b  5b 30 4b 3a 71 1b db db  |.[25;1H.[0K:q...|
                                                     ^^^^^
00000010  da 25 aa da 8a 42 b5 b4  05 5a fd 72 6f 6f 74 40  |.%...B...Z.root@|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000020  6f 6d 61 70 2d 34 34 33  30 73 64 70 3a 7e 23 20  |omap-4430sdp:~# |

This appears to come from these write calls in vi:

write(1, "\33[25;1H\33[0K:"..., 12)     = 12
write(1, "q"..., 1)                     = 1
write(1, "\33[1;1H\r\33[25;1H- kexec-test 1/9 11%\33[0K\33[1;1H"..., 44) = 44
write(1, "\33[25;1H\33[0K"..., 11)      = 11

It appears to be timing related, as stracing vi produces different output:

- k9?root at omap-4430sdp:~#

00000000  1b 5b 32 35 3b 31 48 1b  5b 30 4b 3a 71 1b 5b 31  |.[25;1H.[0K:q.[1|
00000010  3b 31 48 0d 1b 5b 32 35  3b 31 48 2d 20 6b 39 ff  |;1H..[25;1H- k9.|
                                                     ^^^^^
00000020  72 6f 6f 74 40 6f 6d 61  70 2d 34 34 33 30 73 64  |root at omap-4430sd|
00000030  70 3a 7e 23 20                                    |p:~# |

Similar, but more severe effects can be seen with "dmesg | less":

00000000  0d 72 6f 6f 74 40 6f 6d  61 70 2d 34 34 33 30 73  |.root at omap-4430s|
00000010  64 70 3a 7e 23 20 64 6d  65 73 67 20 7c 20 6c 65  |dp:~# dmesg | le|
00000020  73 73 1b 5b 4a 0d 0a 1b  5b 30 3b 30 48 1b 5b 4b  |ss.[J...[0;0H.[K|
00000030  0d 0a 1b 5b 4b 7e cd d4  a4 68 b4 b5 ca 35 52 da  |...[K~...h...5R.|
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000040  b4 b5 ca 35 52 da b4 b5  ca 35 52 da b4 b5 ca 35  |...5R....5R....5|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000050  52 da b4 b5 ca 35 52 da  b4 b5 ca 35 52 da b4 b5  |R....5R....5R...|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000060  ca 35 52 da b4 b5 ca 35  52 da b4 b5 ca 35 52 da  |.5R....5R....5R.|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000070  b4 b5 ca 35 52 da b4 b5  ca 35 52 da b4 b5 ca 35  |...5R....5R....5|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000080  52 da b4 b5 ca 35 52 da  b4 b5 ca 35 52 da b4 b5  |R....5R....5R...|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000090  ca 35 52 da b4 25 aa da  82 42 b5 b4 b5 6a b4 75  |.5R..%...B...j.u|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
000000a0  6a cd d1 85 b9 91 85 c9  91 81 4a b9 c1 d5 d1 6d  |j.........J....m|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
000000b0  da c1 6a 6d da c1 da 82  42 b5 b4 b5 4a ea eb 8b  |..jm....B...J...|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
000000c0  57 cb eb 16 12 2a cb ab  17 81 7a b9 81 82 a1 e5  |W....*....z.....|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
000000d0  cd a5 8d 85 b1 81 1a 41  55 81 82 c2 c1 6a 52 b4  |.......AU....jR.|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
000000e0  b4 b5 8a 2a cb ab 17 81  b2 95 c9 cd a5 bd b9 81  |...*............|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
000000f0  a2 72 8a b2 72 82 5a 02  42 92 b5 ad 01 c9 b5 ad  |.r..r.Z.B.......|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000100  b5 82 0d b9 0a c9 b5 b1  a5 b9 d5 e1 b9 7a c9 9d  |.............z..|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000110  b9 aa ad a5 02 42 3a 8d  8d 81 b2 95 c9 cd a5 bd  |.....B:.........|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000120  b9 81 a2 72 ba 72 a2 02  42 3a 35 35 2a 29 09 d2  |...r.r..B:55*)..|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000130  52 53 48 68 b4 b5 0a b2  02 9a d5 05 05 a9 ea cb  |RSHh............|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000140  0b 52 14 2e 2e 48 4c 9b  90 31 33 3a 33 30 3a 30  |.R...HL..13:30:0|
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
00000150  39 20 42 53 54 20 32 30  31 38 0d 0a 1b 5b 4b 43  |9 BST 2018...[KC|
00000160  50 55 3a 20 41 52 4d 76  37 20 50 72 6f 63 65 73  |PU: ARMv7 Proces|

Since this uses a USB adapter (built onto the board) it could be
that there could be a bug in the driver for that rather than the
OMAP4430 SDP, but I've no way to check that hypothesis.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
