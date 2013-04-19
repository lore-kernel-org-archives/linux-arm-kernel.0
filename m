From: itooo@itooo.com (Greg)
Date: Fri, 19 Apr 2013 18:02:19 +0200
Subject: MVEBU and MVNETA driver
In-Reply-To: <51715BC7.3040906@free-electrons.com>
References: <5171419C.2090003@itooo.com> <20130419131237.GC22440@1wt.eu>
 <517150FF.9010806@itooo.com> <20130419144324.GD22440@1wt.eu>
 <51715BC7.3040906@free-electrons.com>
Message-ID: <51716A8B.9080903@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/04/2013 16:59, Gregory CLEMENT a ?crit :
> On 04/19/2013 04:43 PM, Willy Tarreau wrote:
>> On Fri, Apr 19, 2013 at 04:13:19PM +0200, Greg wrote:
>>> Willy, thanks for your fast an accurate answer, this seems to solve the
>>> stability issue but not the performance issue.
>> OK.
>>
>>> Please look at this strange behavior : 1 iperf will only transmit at
>>> ~100Mbps, 100 parallel iperf will transmit at ~950Mb. Reception is not
>>> an issue.
>>> I'm thinking of a socket <-> txQ relationship that would limit
>>> transmission rate, but I have no idea on how this is implemented.
>> Strange, I have not experienced this. Yes a socket size limit could be
>> the reason. Have you tried with netcat or any simple TCP server instead ?
>>
> I also have this behavior:
> iperf -c 192.168.0.19 -d
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 85.3 KByte (default)
> ------------------------------------------------------------
> ------------------------------------------------------------
> Client connecting to 192.168.0.19, TCP port 5001
> TCP window size: 20.7 KByte (default)
> ------------------------------------------------------------
> [  5] local 192.168.0.37 port 48473 connected with 192.168.0.19 port 5001
> [  4] local 192.168.0.37 port 5001 connected with 192.168.0.19 port 36987
> [ ID] Interval       Transfer     Bandwidth
> [  5]  0.0-10.0 sec   128 MBytes   107 Mbits/sec
> [  4]  0.0-10.0 sec  1.07 GBytes   919 Mbits/sec
>
> but I only need 10 thread in iperf to be close to the Gb
> ------------------------------------------------------------
> Client connecting to 192.168.0.19, TCP port 5001
> TCP window size: 20.7 KByte (default)
> ------------------------------------------------------------
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-10.0 sec   117 MBytes  98.2 Mbits/sec
> [ 12]  0.0-10.0 sec  42.5 MBytes  35.6 Mbits/sec
> [  8]  0.0-10.0 sec   131 MBytes   110 Mbits/sec
> [  5]  0.0-10.0 sec   127 MBytes   107 Mbits/sec
> [  3]  0.0-10.0 sec   118 MBytes  98.4 Mbits/sec
> [ 10]  0.0-10.0 sec   130 MBytes   109 Mbits/sec
> [  7]  0.0-10.0 sec   128 MBytes   107 Mbits/sec
> [  9]  0.0-10.0 sec  83.2 MBytes  69.7 Mbits/sec
> [  6]  0.0-10.0 sec   110 MBytes  92.5 Mbits/sec
> [ 11]  0.0-10.0 sec   132 MBytes   110 Mbits/sec
> [SUM]  0.0-10.0 sec  1.09 GBytes   936 Mbits/sec
>
> I am not a network expert and until now we didn't try to
> have the best performance the hardware can offer. We mainly
> focused on features.
>
I've got the same numbers here.
A simple tool like netcat shows ~470Mbps but this limited by the CPU.
Iperf isn't CPU limited

The same test with Marvell LSP shows ~940Mbps in both directions.

Regards,
