From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 19:18:46 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel> <20150430130028.GF3488@pd.tnic>
 <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
Message-ID: <20150430171846.GJ3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:57:46AM -0700, Loc Ho wrote:
> I had read all the emails interaction. Yes I can write a single EDAC
> driver. But I actually have multiple instances and single instance of
> the same IP's. For example, I have 4 DDR controllers, 4 CPU domains,
> one L3 and one SoC. If you can suggest to me how this would work with
> devicetree, I might be able to make it works. But from HW point of
> view (take the memory controller as an example), there is really 4
> hardware blocks and some shared IP's block for status. It is much
> simple representation with multiple instance of the driver.

Your whole error reporting is done roughly through the same registers,
as Arnd pointed out. Why can't you build your single driver around that
and based on the error type being reported, multiplex inside a *single*
interrupt handler to the proper decoding routines.

> I think we should first agreed on the DT binding and let's not worry
> about APEI. Then, whether we have one file or multiple file. Again,
> the HW consist of:
> 
> 1. One top level interrupt and status registers
> 2. CSW, MCB A and MCB B for detection of any active memory controllers
> 3. 4 individual memory controller instance
> 4. 4 CPU domain instance with its own individual L2 registers
> 5. Each CPU has instance own L1
> 6. One L3 instance
> 7. One SoC instance

And all of those are separate IP blocks and they can be integrated with
other, non APM hardware, or do those things all belong together? IOW,
can we expect such IP blocks to appear in other hw platforms or are
they all custom APM design which need to go together due to proprietary
coherency protocol or whatever, for example?

> As for as what is useful, we find that the memory controller and the
> L1 and L2 are useful as it provides info for errors - for HW/system
> debugging as well as margin of DDR.

Sounds like all is useful.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
