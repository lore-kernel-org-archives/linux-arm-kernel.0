From: Sunil.Goutham@caviumnetworks.com (Goutham, Sunil)
Date: Mon, 21 Sep 2015 17:08:24 +0000
Subject: net: thunderx: Support for upto 96 queues for a VF
In-Reply-To: <20150921163118.GG5648@mwanda>
References: <20150921163118.GG5648@mwanda>
Message-ID: <CY1PR0701MB16613A356BAAB39BB3593F7893460@CY1PR0701MB1661.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

Thanks for pointing out.

Here we are trying to combine multiple SRIOV VF's resources into one
so that one user visible interface can have upto 96 queues which otherwise
is limited to 8 queues. The main VF is considered as primary VF and other's
are secondary VFs.

'nic->sqs_count' of a primary VF holds the number of secondary VF's resources
that it should request PF to allocate. This is initialized equal to number of
CPUs online at the time of driver probe. Hence 'nic->sqs_count' is non-zero
for primary VF.

Also please see inline.

Thanks,
Sunil.

________________________________________
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: Monday, September 21, 2015 10:01 PM
To: sgoutham at cavium.com
Cc: linux-arm-kernel at lists.infradead.org
Subject: re: net: thunderx: Support for upto 96 queues for a VF

Hello Sunil Goutham,

The patch 92dc87697e6a: "net: thunderx: Support for upto 96 queues
for a VF" from Aug 30, 2015, leads to the following static checker
warning:

        drivers/net/ethernet/cavium/thunder/nicvf_main.c:398 nicvf_request_sqs()
        warn: we tested 'nic->sqs_count' before and it was 'true'

drivers/net/ethernet/cavium/thunder/nicvf_main.c
   376  /* Request PF to allocate additional Qsets */
   377  static void nicvf_request_sqs(struct nicvf *nic)
   378  {
   379          union nic_mbx mbx = {};
   380          int sqs;
   381          int sqs_count = nic->sqs_count;
   382          int rx_queues = 0, tx_queues = 0;
   383
   384          /* Only primary VF should request */
   385          if (nic->sqs_mode ||  !nic->sqs_count)
                                      ^^^^^^^^^^^^^^^
Check.

   386                  return;
   387
   388          mbx.sqs_alloc.msg = NIC_MBOX_MSG_ALLOC_SQS;
   389          mbx.sqs_alloc.vf_id = nic->vf_id;
   390          mbx.sqs_alloc.qs_count = nic->sqs_count;
   391          if (nicvf_send_msg_to_pf(nic, &mbx)) {
   392                  /* No response from PF */
   393                  nic->sqs_count = 0;
   394                  return;

Set and return.
Sunil>> Here VF is sending a mailbox message to PF for requesting sqs_count
number of resources. For all messages sent by VF, PF acknowledges with an 
ack or a proper reply. If this is not received by VF, it considers the message is lost and sets sqs_count to zero.
Yes, 'return' is not needed here since it's checked below anyway.

   395          }
   396
   397          /* Return if no Secondary Qsets available */
   398          if (!nic->sqs_count)
   399                  return;

This seems like dead code.
Sunil>> Here there is no issue with mailbox messages but PF sent a reply
to VF that it couldn't allocate any additional resources. sqs_count is set to zero
at VF's mailbox response handling code. Hence this is not a dead code. 

   400

regards,
dan carpenter
