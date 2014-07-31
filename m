From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 31 Jul 2014 15:36:35 +0200
Subject: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <20140731131702.GC4375@pd.tnic>
References: <9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl>
 <20140731113324.GB4375@pd.tnic>
 <808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl>
 <20140731131702.GC4375@pd.tnic>
Message-ID: <a366b39c-b354-4d90-8b1e-71e74ab77cf3@BL2FFO11FD011.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 03:17 PM, Borislav Petkov wrote:
> On Thu, Jul 31, 2014 at 02:13:48PM +0200, Michal Simek wrote:
>> Mixing two drivers in the one file is not a good idea because with
>> more memory controllers it is just a mess and you are not able to
>> cover all cases.
> 
> Why is it a mess?

Mixing functions for two/more different controller seems to me
really messy. Also having that drivers separated is useful if
driver probe fails for one controller (you can write the code for it
but it won't be nice).

>> If this is just about providing uniq number we can easily extend
>> binding and provide that uniq value. That's remind me solution with
>> edac_mc_get_id() can caused that you won't have exact number all the
>> time - depends on driver loading (deferred probing too).
> 
> -ENOPARSE for this sentence.

I meant by this this scenario - please correct me if I am completely wrong
because I am not playing with this subsystem. My expectation is that
memory controller number should be same all the time.

two memory controllers with the same edac driver.

Normal calling sequence:
X probe - number 0
Y probe - number 1

Different order/name (I think order is taken at the first place)
in DTS should caused that X will have number 1 and Y number 0.

Another scenario:
two controllers and one with external gpio reset for example.

X probe is called but gpio controller is not ready and gpio driver returns
-EPROBE_DEFER then Y probe is called and get number 0. Then X probe is called
again and get number 1.


>> One option via DT can be via aliases where you can easily specify
>> order. But all of these issues can be solved in follow-up patch.
> 
> Whatever you do, it should be designed cleanly and not introduce some
> homegrown solution.

Definitely I 100% agree with you. That's why I think this should
be solved separately.

Thanks,
Michal
