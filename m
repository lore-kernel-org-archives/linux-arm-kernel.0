From: slash.tmp@free.fr (Mason)
Date: Tue, 14 Mar 2017 13:05:36 +0100
Subject: Neophyte questions about PCIe
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFB0422@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
 <c0a353cb-aa1f-25db-eccd-7a1618e655b3@free.fr>
 <20170313214024.GD8232@bhelgaas-glaptop.roam.corp.google.com>
 <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFFB0422@AcuExch.aculab.com>
Message-ID: <ba1c544d-e2d3-3bc5-c4a1-7072c00a108f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/2017 11:23, David Laight wrote:

> Mason wrote:
> 
>> I'd like to push support for this PCIe controller upstream.
>>
>> Is the code I posted on the right track?
>> Maybe I can post a RFC patch tomorrow?
> 
> I think you need to resolve the problem of config space (and IO) cycles
> before the driver can be deemed usable.

You're alluding to the (unfortunate) muxing of config and mem spaces
on my controller, where concurrent accesses by two different threads
would blow the system up.

You've suggested sending IPIs in the config space accessor, in order
to prevent other CPUs from starting a mem access. But this doesn't
help if a mem access is already in flight, AFAIU.

I fear there is nothing that can be done in SW, short of rewriting
drivers such that mem space accesses are handled by a driver-specific
call-back which could take care of all required locking.

AFAICT, my only (reasonable) option is putting a big fat warning
in the code, and pray that concurrent accesses never happen.
(I'll test with a storage stress test on a USB3 drive.)

In parallel, I'm trying to convince management that the HW needs
fixing ASAP.

Regards.
