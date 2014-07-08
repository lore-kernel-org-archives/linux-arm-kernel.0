From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Mon, 7 Jul 2014 19:20:29 -0700
Subject: Issue found in Armada 370: "No buffer space available" error during
 continuous ping
Message-ID: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
Good day.

We have previously discussed before on Armada 370 ethernet issues
(resolved via your suggestion/patches).

We just found out recently that ethernet (SGMII) connection encounters
"No buffer space available" error during continuous ping to other
nodes in the same network (ie, even ping to the server). It is
frequently around the 17th packet.
# Please see attached log (ping_error.txt) for more info.

Here are the details:

Processor: Marvell Armada 370 88F6707
Ethernet module: Marvell 88E1512
Board: Custom
Kernel versions tried:
- 3.13.9 (issue exists)
- 3.10.24 (issue does NOT exist)
- 3.13.9 (issue does NOT exist)
U-Boot versions tried: 2013_Q1 and 2013_Q3 from Marvell extranet

Some more important notes:
- This does not happen in wlan connections.
- This happens in 10, 100 and 1000Mbps connections.

Is there a known issue for this?

As always, thank you very much.

Regards,
Maggie Roxas
-------------- next part --------------
root at localhost:~# ethtool eth0                                                  
Settings for eth0:                                                              
        Supported ports: [ TP MII ]                                             
        Supported link modes:   10baseT/Half 10baseT/Full                       
                                100baseT/Half 100baseT/Full                     
                                1000baseT/Half 1000baseT/Full                   
        Supported pause frame use: No                                           
        Supports auto-negotiation: Yes                                          
        Advertised link modes:  10baseT/Half 10baseT/Full                       
                                100baseT/Half 100baseT/Full                     
                                1000baseT/Half 1000baseT/Full                   
        Advertised pause frame use: No                                          
        Advertised auto-negotiation: Yes                                        
        Speed: 1000Mb/s                                                         
        Duplex: Full                                                            
        Port: MII                                                               
        PHYAD: 0                                                                
        Transceiver: external                                                   
        Auto-negotiation: on                                                    
        Link detected: yes                                                      
root at localhost:~# ping 10.42.0.1                                                
PING 10.42.0.1 (10.42.0.1) 56(84) bytes of data.                                
64 bytes from 10.42.0.1: icmp_seq=1 ttl=64 time=0.222 ms                        
64 bytes from 10.42.0.1: icmp_seq=2 ttl=64 time=0.188 ms                        
64 bytes from 10.42.0.1: icmp_seq=3 ttl=64 time=0.191 ms                        
64 bytes from 10.42.0.1: icmp_seq=4 ttl=64 time=0.181 ms                        
64 bytes from 10.42.0.1: icmp_seq=5 ttl=64 time=0.186 ms                        
64 bytes from 10.42.0.1: icmp_seq=6 ttl=64 time=0.184 ms                        
64 bytes from 10.42.0.1: icmp_seq=7 ttl=64 time=0.184 ms                        
64 bytes from 10.42.0.1: icmp_seq=8 ttl=64 time=0.181 ms                        
64 bytes from 10.42.0.1: icmp_seq=9 ttl=64 time=0.183 ms                        
64 bytes from 10.42.0.1: icmp_seq=10 ttl=64 time=0.181 ms                       
64 bytes from 10.42.0.1: icmp_seq=11 ttl=64 time=0.185 ms                       
64 bytes from 10.42.0.1: icmp_seq=12 ttl=64 time=0.180 ms                       
64 bytes from 10.42.0.1: icmp_seq=13 ttl=64 time=0.193 ms                       
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
^C                                                                              
--- 10.42.0.1 ping statistics ---                                               
17 packets transmitted, 13 received, 23% packet loss, time 34995ms              
rtt min/avg/max/mdev = 0.180/0.187/0.222/0.018 ms                               
root at localhost:~# ethtool -s eth0 speed 100 duplex full                         
root at localhost:~# ethtool eth0                                                  
Settings for eth0:                                                              
        Supported ports: [ TP MII ]                                             
        Supported link modes:   10baseT/Half 10baseT/Full                       
                                100baseT/Half 100baseT/Full                     
                                1000baseT/Half 1000baseT/Full                   
        Supported pause frame use: No                                           
        Supports auto-negotiation: Yes                                          
        Advertised link modes:  100baseT/Full                                   
        Advertised pause frame use: No                                          
        Advertised auto-negotiation: Yes                                        
        Speed: 100Mb/s                                                          
        Duplex: Full                                                            
        Port: MII                                                               
        PHYAD: 0                                                                
        Transceiver: external                                                   
        Auto-negotiation: on                                                    
        Link detected: yes                                                      
root at localhost:~# ping 10.42.0.1                                                
PING 10.42.0.1 (10.42.0.1) 56(84) bytes of data.                                
64 bytes from 10.42.0.1: icmp_seq=1 ttl=64 time=0.441 ms                        
64 bytes from 10.42.0.1: icmp_seq=2 ttl=64 time=0.213 ms                        
64 bytes from 10.42.0.1: icmp_seq=3 ttl=64 time=0.199 ms                        
64 bytes from 10.42.0.1: icmp_seq=4 ttl=64 time=0.201 ms                        
64 bytes from 10.42.0.1: icmp_seq=5 ttl=64 time=0.206 ms                        
64 bytes from 10.42.0.1: icmp_seq=6 ttl=64 time=0.202 ms                        
64 bytes from 10.42.0.1: icmp_seq=7 ttl=64 time=0.199 ms                        
64 bytes from 10.42.0.1: icmp_seq=8 ttl=64 time=0.201 ms                        
64 bytes from 10.42.0.1: icmp_seq=9 ttl=64 time=0.189 ms                        
64 bytes from 10.42.0.1: icmp_seq=10 ttl=64 time=0.202 ms                       
64 bytes from 10.42.0.1: icmp_seq=11 ttl=64 time=0.196 ms                       
64 bytes from 10.42.0.1: icmp_seq=12 ttl=64 time=0.207 ms                       
64 bytes from 10.42.0.1: icmp_seq=13 ttl=64 time=0.204 ms                       
64 bytes from 10.42.0.1: icmp_seq=14 ttl=64 time=0.199 ms                       
64 bytes from 10.42.0.1: icmp_seq=15 ttl=64 time=0.196 ms                       
64 bytes from 10.42.0.1: icmp_seq=16 ttl=64 time=0.202 ms                       
64 bytes from 10.42.0.1: icmp_seq=17 ttl=64 time=0.199 ms                       
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
^C                                                                              
--- 10.42.0.1 ping statistics ---                                               
21 packets transmitted, 17 received, 19% packet loss, time 38996ms              
rtt min/avg/max/mdev = 0.189/0.215/0.441/0.056 ms                               
root at localhost:~# ethtool -s eth0 speed 10 duplex full                          
root at localhost:~# ethtool eth0                                                  
Settings for eth0:                                                              
        Supported ports: [ TP MII ]                                             
        Supported link modes:   10baseT/Half 10baseT/Full                       
                                100baseT/Half 100baseT/Full                     
                                1000baseT/Half 1000baseT/Full                   
        Supported pause frame use: No                                           
        Supports auto-negotiation: Yes                                          
        Advertised link modes:  10baseT/Full                                    
        Advertised pause frame use: No                                          
        Advertised auto-negotiation: Yes                                        
        Speed: 10Mb/s                                                           
        Duplex: Full                                                            
        Port: MII                                                               
        PHYAD: 0                                                                
        Transceiver: external                                                   
        Auto-negotiation: on                                                    
        Link detected: yes                                                      
root at localhost:~# ping 10.42.0.1                                                
PING 10.42.0.1 (10.42.0.1) 56(84) bytes of data.                                
64 bytes from 10.42.0.1: icmp_seq=1 ttl=64 time=0.447 ms                        
64 bytes from 10.42.0.1: icmp_seq=2 ttl=64 time=0.396 ms                        
64 bytes from 10.42.0.1: icmp_seq=3 ttl=64 time=0.390 ms                        
64 bytes from 10.42.0.1: icmp_seq=4 ttl=64 time=0.388 ms                        
64 bytes from 10.42.0.1: icmp_seq=5 ttl=64 time=0.390 ms                        
64 bytes from 10.42.0.1: icmp_seq=6 ttl=64 time=0.391 ms                        
64 bytes from 10.42.0.1: icmp_seq=7 ttl=64 time=0.387 ms                        
64 bytes from 10.42.0.1: icmp_seq=8 ttl=64 time=0.385 ms                        
64 bytes from 10.42.0.1: icmp_seq=9 ttl=64 time=0.386 ms                        
64 bytes from 10.42.0.1: icmp_seq=10 ttl=64 time=0.385 ms                       
64 bytes from 10.42.0.1: icmp_seq=11 ttl=64 time=0.386 ms                       
64 bytes from 10.42.0.1: icmp_seq=12 ttl=64 time=0.377 ms                       
64 bytes from 10.42.0.1: icmp_seq=13 ttl=64 time=0.373 ms                       
64 bytes from 10.42.0.1: icmp_seq=14 ttl=64 time=0.378 ms                       
64 bytes from 10.42.0.1: icmp_seq=15 ttl=64 time=0.384 ms                       
64 bytes from 10.42.0.1: icmp_seq=16 ttl=64 time=0.393 ms                       
64 bytes from 10.42.0.1: icmp_seq=17 ttl=64 time=0.384 ms                       
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
ping: sendmsg: No buffer space available                                        
^C                                                                              
--- 10.42.0.1 ping statistics ---                                               
21 packets transmitted, 17 received, 19% packet loss, time 38996ms              
rtt min/avg/max/mdev = 0.373/0.389/0.447/0.023 ms         
root at localhost:~# uname -a                                                      
Linux localhost.localdomain 3.13.9 #1 SMP Tue Jul 8 09:23:06 PHT 2014 armv7l arm
v7l armv7l GNU/Linux                 
